class ShopsController < ApplicationController
  before_filter :require_login
  before_filter :override_db
  skip_before_filter :require_login, :only => :show

  def index
    if params[:area_id] && !params[:chain_id]
      @area = Area.find(params[:area_id])
      #@shops = Shop.where(area_id: @area.id).order('created_at DESC')
      current_user.admin == true ? @shops = Shop.where(area_id: @area.id).order('adds') :  @shops = Shop.where(area_id: @area.id).where(chain_id: current_user.chain.id).order('created_at DESC')
    elsif params[:area_id] && params[:chain_id]
      @area = Area.find(params[:area_id])
      @chain_id = params[:chain_id]
      @shops = Shop.where(area_id: @area.id, chain_id: params[:chain_id]).order('adds')      
    else
      @area = Area.first
    end
  end

  def edit
    @city = City.find(params[:city_id])
    @shop = Shop.find(params[:id])  
  end

  def create    
    redirect_to edit_user_path if !current_user.admin?

    if params[:shop]
      @city = City.find(params[:city_id])
      @chain = Chain.find(params[:shop][:chain_id])
      params[:shop][:name] = @chain.name if @chain
      @shop = Shop.create(params[:shop]) if current_user.admin?

      @shop.set_shop_location(params[:city_id], params[:shop][:area_id], :create)

      @shops = Shop.where(area_id: @shop.area.id, chain_id: @shop.chain_id).order('adds')
      #render 'edit'
    end

    #if params[:city_id] && params[:area_id] && params[:chain_id] && params[:shop][:adds] != ''
    #  @area = Area.find(params[:area_id]) if params[:area_id]
    #  @chain = Chain.find(params[:chain_id]) if params[:chain_id]
    #  @shop = Shop.create(params[:shop])
    #  #render 'cities/show'
    #elsif params[:shop][:area_id] != '' && params[:shop][:adds] != ''
    #  @area = Area.find(params[:shop][:area_id])
    #  @chain = current_user.chain if current_user.seller?
    #  params[:shop][:chain_id] = @chain.id.to_s
    #  @shop = Shop.create(params[:shop])
    #  current_user.admin == true ? @shops = Shop.where(area_id: @area.id).order('created_at DESC') :  @shops = Shop.where(area_id: @area.id).where(chain_id: current_user.chain.id).order('created_at DESC')      
    #  render 'index'      
    #else
    #  redirect_to cities_path(@city.id)
    #end
  end

  def update
    redirect_to edit_user_path if !current_user.admin?
    
    if params[:city_id] && params[:id]
      @shop = Shop.find(params[:id])
      @shop.adds = params[:shop][:adds]
      @shop.phone = params[:shop][:phone]
      @shop.save if current_user.admin?
      @shops = Shop.where(area_id: @shop.area.id, chain_id: @shop.chain_id).order('adds')
      
      #render 'index'

      #@area = Area.find(params[:area_id]) if params[:area_id]
      #@chain = Chain.find(params[:chain_id]) if params[:chain_id]
      #@shop = Shop.find(params[:id])
      #@shop.update_attributes(params[:shop])
      #render 'cities/show'
    else
      redirect_to edit_user_path(current_user)
    end
  end

  def destroy
    redirect_to edit_user_path if !current_user.admin?

    @shop_id = params[:id]
    @shop = Shop.find(params[:id])
    @shop.set_shop_location(params[:city_id], @shop.area_id, :destroy)
    @shops = Shop.where(area_id: @shop.area.id, chain_id: @shop.chain_id).order('adds')

    if params[:id]
      @shop.destroy if current_user.admin?
      #redirect_to edit_user_path(current_user)

    elsif params[:city_id] && params[:area_id] && params[:chain_id] && params[:id]
      @area = Area.find(params[:area_id]) if params[:area_id]
      @chain = Chain.find(params[:chain_id]) if params[:chain_id]
      @shop = Shop.find(params[:id])
      @shop.destroy
      #render 'cities/show'
    elsif params[:city_id] == nil && params[:area_id] && params[:chain_id] == nil && params[:id]
      @shop = Shop.find(params[:id])
      @shop.destroy
      @area = Area.find(params[:area_id])
      current_user.admin == true ? @shops = Shop.where(area_id: @area.id).order('created_at DESC') :  @shops = Shop.where(area_id: @area.id).where(chain_id: current_user.chain.id).order('created_at DESC')
      #render 'index'  
    #else      
      #redirect_to cities_path(@city.id)
    end
  end

  def show
    @shop = Shop.find(params[:id])

    #if params[:id] 
      #@area = Area.find(params[:area_id]) if params[:area_id]
      #@chain = Chain.find(params[:id]) || Chain.first
      #render 'cities/show'
    #else
      #redirect_to cities_path(@city.id)
    #end
  end

end
