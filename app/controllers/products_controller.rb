class ProductsController < ApplicationController
  before_filter :check_admin, except: :show

  def show
    redirect_to :root unless @current_city
    @product = Product.find(params[:id])
    @shop_products = ShopProduct.where(product_id: @product.id).order('price')
  end

  def index
    @products = Product.all
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])    
    @product.update_attributes(params[:product])
    redirect_to products_path
  end

  def create
    @product = Product.create(params[:product])
    redirect_to products_path
  end
  
  def destroy
    Product.find(params[:id]).destroy
    redirect_to products_path
  end

  private
    def check_admin
      if !current_user || !current_user.admin?
        redirect_to :root
      end
    end
end
