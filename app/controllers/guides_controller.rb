class GuidesController < ApplicationController
    def index
        query = query_params
        if authenticated?
            puts "Authenticated request. Returning all guides."
            guides = Guide.where(query).all
            render :json => guides
        else
            query[:published] = true
            puts "Unauthenticated request. Returning only published guides."
            guides = Guide.includes(sections: [:oauth_config]).where(query)
            render :json => guides, include: [sections: {include: :oauth_config}]
        end
    end

    def show
        guide_id = params[:id]
        guide = Guide.includes(sections: [:oauth_config]).find(guide_id)
        if authenticated?
            puts "Authenticated request. Returning requested guide."
            render :json => guide, include: [sections: {include: :oauth_config}]
        else
            puts "Unauthenticated request."
            if guide.published
                puts "Returning guide anyways because it is published."
                render :json => guide, include: :sections
            else
                puts "Unauthorized access attempt."
                render :json => {error: "You are not authorized to view this resource."}, status: 403
            end
        end
    end

    def create
        @guide = guides_params
        @guide[:published] = false

        result = Guide.create(@guide)

        render :json => result
    end

    def update
        if authenticated?
            puts "Authenticated request. Updating the guide."
            id = params[:id]
            guide = guides_params

            if guide[:sections_attributes]
                guide[:read_time] = calculate_read_time(guide)
            end

            result = Guide.where(id: id).update(guide).first

            delete_image_in_aws(guide)

            render :json => result, include: [sections: {include: :oauth_config}]
        else
            puts "Unauthorized access attempted."
            render :json => {error: "You are not authorized to modify this resource."}, status: 403
        end
    end

    def destroy
        guide_id = params[:id]
        result = Guide.destroy(guide_id)
        render :json => result
    end

    private
        def guides_params
            params.require(:guide).permit(
                :title, :description, :published, :id, 
                :sections_attributes => [:content, :id, :section_type, :ordinal, :_destroy,
                    :oauth_config_attributes => [
                        {:scopes => []}, :base_url, :id, :scope_delimiter, :scope_param_name,
                        :redirect_uri_param_name, :client_id_param_name
                    ]
                ]
            )
        end

        def calculate_read_time(guide)
            number_of_words = 0
            average_words_read_per_minute = 170

            guide[:sections_attributes].each do |section|
                if section[:section_type] == "markdown"
                    number_of_words = number_of_words + section[:content].split(" ").size 
                end
            end

            read_time = number_of_words / average_words_read_per_minute
            read_time
        end

        def query_params
            query = params.permit(:series_id, :published, :title)
            query = replace_nulls_with_nil(query)
            query[:published] = true unless @user

            query
        end

        def replace_nulls_with_nil(query={})
            query.each do |k, v|
                if query[k] == "null"
                    query[k] = nil
                end
            end
        end

        def delete_image_in_aws(guide) 
            if guide[:sections_attributes]
                guide[:sections_attributes].each do |section|
                    if section[:section_type] == "image" && section[:_destroy] == 1
                        file_name = section[:content].sub("https://#{ENV['S3_BUCKET']}.s3.amazonaws.com/", "")
                        client = Aws::S3::Client.new
                        result = client.delete_object({key: file_name, bucket: ENV['S3_BUCKET']})
                    end
                end
            end
        end
end
