class PromotionsController < ApplicationController
  before_filter :require_login

  def index
    @promotions = current_user.admin? == true ? Promotion.all : current_user.promotions
  end

  def create
    if params[:promotion][:id]
      @promotion = Promotion.find(params[:promotion][:id])
      @promotion.update_attributes(params[:promotion])
    else
      params[:promotion][:user_id] = current_user.id
      @promotion = Promotion.create(params[:promotion])
    end
  end

  def edit
    @promotion = Promotion.find(params[:id])
  end

  def update
    @promotion = Promotion.find(params[:id])
    params[:promotion][:balance] = params[:promotion][:balance].to_i * 10
    @promotion.update_attributes(params[:promotion])
    respond_to do |format|
      format.html { redirect_to promotions_path }
      format.js  {render :layout => false }
    end
  end

  def start
    @promotion = Promotion.find(params[:promotion_id])
  end

  def search
    @promotions = Promotion.where(key: params[:key])
    render 'index'
  end

  def destroy
    @promotion = Promotion.find(params[:id])
    @promotion.destroy if @promotion.user == current_user || current_user.admin?
    redirect_to promotions_path
  end

end