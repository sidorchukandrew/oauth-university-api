class GuidesController < ApplicationController
    def index
        query = query_params
        if query
            @guides = Guide.includes(:sections).where(query)
            render :json => @guides, include: :sections
        else
            @guides = Guide.all
            render :json => @guides
        end
    end

    def show
        guide_id = params[:id]
        result = Guide.includes(:sections).find(guide_id)

        render json: result, include: :sections
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
                :sections_attributes => [:content, :id, :section_type, :ordinal]
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
        end

        def replace_nulls_with_nil(query={})
            query.each do |k, v|
                if query[k] == "null"
                    query[k] = nil
                end
            end
        end
end
