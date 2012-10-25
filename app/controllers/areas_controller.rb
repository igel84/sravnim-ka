class AreasController < ApplicationController
  skip_before_filter :require_login, :only => :wellcom

  def index
    if params[:city_id]
      @areas = Area.all#.where(city_id: params[:city_id])
    else
      @areas = Area.all
    end
  end

  def show
    if params[:id] 
      @area = Area.find(params[:id]) || Area.first
      render 'cities/show'
    else
      redirect_to cities_path(@city.id)
    end
  end

end