class SeriesController < ApplicationController
  def index
    @series = Series.all
    render :json => @series
  end

  def create
    @series = series_params
    @series[:published] = false

    result = Series.create(@series)

    render json: result
  end

  def show
    series_id = params[:id]
    result = Series.find(series_id)

    render json: result
  end

  def update
    updates = series_params
    id = params[:id]
    result = Series.where(id: id).update(updates).first
    render json: result
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
      params.require(:series).permit(:image_url, :title, :description, :published, :published_date)
    end
end
