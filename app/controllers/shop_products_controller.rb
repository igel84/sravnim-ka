class ShopProductsController < ApplicationController
  skip_before_filter :require_login
  #skip_before_filter :override_db, :only => [:index, :edit]

  def new
    @shop_product = ShopProduct.new
    #@shop_product.product_id = 1
  end

  def edit
    @shop = Shop.find(params[:shop_id])    
    
    @type = 'shop'
    @shop_id = @shop.id
    @area_id = @shop.area_id
    @city_id = @current_city.id
    @chain_id = @shop.chain_id
    
    @shop_products = @shop.shop_products
  end

end