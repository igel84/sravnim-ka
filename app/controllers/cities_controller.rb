class CitiesController < ApplicationController
  skip_before_filter :override_db, :only => :index
  skip_before_filter :require_login, :only => :wellcom
  before_filter :check_admin, only: [:update_shop_raiting, :set_shops_prices]

  #time for Voronezh
  def index
    @current_city = City.find(1)
    redirect_to controller: 'cities', action: 'show', subdomain: "voronezh" 
  end

  def show
    if @current_city.id != 1
      render 'error'
    end

    if @current_city && params[:area_id].nil? && params[:chain_id].nil? && params[:shop_id].nil?
      @city = @current_city
      session['city'] = @city.id
      @temp_shops = Shop.order('raiting').page params[:page]
    
    elsif @current_city && !params[:area_id].nil? && params[:chain_id].nil? && params[:shop_id].nil?
      @city = @current_city
      @area = Area.find(params[:area_id])
      session['city'] = @city.id      
      @temp_shops = Shop.where(area_id: @area.id).order('raiting').page params[:page]

    elsif @current_city && params[:area_id].nil? && !params[:chain_id].nil? && params[:shop_id].nil?
      @city = @current_city
      @chain = Chain.find(params[:chain_id])
      session['city'] = @city.id      
      @temp_shops = Shop.where(chain_id: @chain.id).order('raiting').page params[:page]

    elsif @current_city && !params[:area_id].nil? && !params[:chain_id].nil? && params[:shop_id].nil?
      @city = @current_city
      @area = Area.find(params[:area_id])
      @chain = Chain.find(params[:chain_id])
      session['city'] = @city.id      
      @temp_shops = Shop.where(chain_id: @chain.id, area_id: @area.id).order('raiting').page params[:page]

    elsif @current_city && params[:area_id].nil? && params[:chain_id].nil? && !params[:shop_id].nil?
      @city = @current_city
      @shop = Shop.find(params[:shop_id])
      session['city'] = @city.id      
      @temp_shops = Shop.where(id: @shop.id).order('raiting').page params[:page]
    end    
  end

  def update_shop_raiting
    Shop.set_global_raiting(@current_city) if @current_city
    redirect_to @current_city
  end

  def set_shops_prices
    Shop.set_global_price(@current_city) if @current_city
    redirect_to @current_city    
  end

  private
    def check_admin
      if !current_user || !current_user.admin?
        redirect_to :root
      end
    end

end
