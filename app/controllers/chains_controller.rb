class ChainsController < ApplicationController
  skip_before_filter :require_login, :only => :wellcom
  before_filter :check_admin

  def check_admin
    if !current_user || !current_user.admin?
      redirect_to :root
    end
  end

  def index
    @chains = Chain.all
  end

  def edit
    @chain = Chain.find(params[:id])    
  end

  def update
    @chain = Chain.find(params[:id])    
    @chain.update_attributes(params[:chain])
    redirect_to chains_path
  end

  def create
    @chain = Chain.create(params[:chain])
    redirect_to chains_path
  end
  
  def show
    if params[:id] 
      @area = Area.find(params[:area_id]) if params[:area_id]
      @chain = Chain.find(params[:id]) || Chain.first
      render 'cities/show'
    else
      redirect_to cities_path(@city.id)
    end
  end

  def destroy
    Chain.find(params[:id]).destroy
    redirect_to chains_path
  end

end
