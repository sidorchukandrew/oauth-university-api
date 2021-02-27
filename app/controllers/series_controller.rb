class SeriesController < ApplicationController
  def index
    query = query_params
     if query
            series = Series.where(query)
            render :json => series, include: :guides
        else
            series = Series.all
            render :json => series, include: :guides
        end
  end

  def create
    @series = series_params
    @series[:published] = false

    result = Series.create(@series)

    render json: result
  end

  def show
    series_id = params[:id]
    result = Series.includes(:guides).find(series_id)

    render json: result, include: :guides
  end

  def update
    updates = series_params

    if params[:guides]
      update_linked_guides
    end

    id = params[:id]
    result = Series.where(id: id).update(updates).first
    render json: result, include: :guides
  end

  def destroy
    series_id = params[:id]
    result = Series.destroy(series_id)
    puts result

    render :json => result
  end

  def update_bulk
    updates = series_params
    ids = params[:ids]
    result = Series.where(id: ids).update(updates)
    render json: result
  end

  def delete_bulk
    ids = params[:ids]
    result = Series.where(id: ids).destroy_all
    puts result
    render json: result
  end

  private

    def series_params
      params.require(:series).permit(:image_url, :title, :description, :published, :published_date, :guides)
    end

    def update_linked_guides
      linked_guides = params[:guides]
      guide_ids_to_link = linked_guides.map {|guide| guide[:id]}

      series = Series.includes(:guides).find(params[:id])
      currently_linked_guide_ids = series.guides.map {|guide| guide[:id]}
      
      guides_to_unlink = currently_linked_guide_ids.select{|linked_id| !guide_ids_to_link.include?(linked_id)}

      series.guides.delete(*guides_to_unlink)
      Guide.where(id: guide_ids_to_link).update(series_id: params[:id])
    end

    def query_params
      query = params.permit(:id, :title)
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
