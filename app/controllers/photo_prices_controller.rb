class PhotoPricesController < ApplicationController
  before_filter :check_admin, except: [:index, :new, :create]

  def index
    if current_user && current_user.admin?
      @photo_prices = PhotoPrice.all
    elsif current_user
      @photo_prices = current_user.photo_prices
    else
      redirect_to new_photo_price_url
    end        
  end

  def create
    @photo_price = PhotoPrice.new(params[:photo_price])
    @photo_price.save
  end

  def destroy
    PhotoPrice.find(params[:id]).destroy if current_user && current_user.admin? #(current_user.admin? || Discussion.find(params[:id]).user == current_user)
    redirect_to photo_prices_url
  end

  private
    def check_admin
      if !current_user || !current_user.admin?
        redirect_to :root
      end
    end
end