class GuidesController < ApplicationController
    def index
        @guides = Guide.all
        render :json => @guides
    end

    def show
    end

    def create
        @guide = guides_params
        @guide[:published] = false

        result = Guide.create(@guide)

        render :json => result
    end

    def update
    end

    def destroy
    end

    private
        def guides_params
            params.require(:guide).permit(:title, :description)
        end
end
