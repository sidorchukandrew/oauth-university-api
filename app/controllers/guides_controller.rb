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
            guides = Guide.includes(:sections).where(query)
            render :json => guides, include: :sections
        end
    end

    def show
        guide_id = params[:id]
        guide = Guide.includes(:sections).find(guide_id)
        if authenticated?
            puts "Authenticated request. Returning requested guide."
            render :json => guide, include: :sections
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
        id = params[:id]
        guide = guides_params
        guide[:read_time] = calculate_read_time(guide)

        result = Guide.where(id: id).update(guide).first

        render :json => result, :include => :sections
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
                :sections_attributes => [:content, :id, :section_type, :ordinal, 
                    :oauth_config_attributes => [:scopes, :base_url]]
            )
        end

        def calculate_read_time(guide)
            number_of_words = 0
            average_words_read_per_minute = 200

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
end
