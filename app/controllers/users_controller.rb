#encoding: utf-8
class UsersController < ApplicationController
  before_filter :require_login
  skip_before_filter :require_login, :only => [:new, :create, :activate]

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to root_url, :notice => "Вы успешно зарегистрировались на сайте"
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
    redirect_to edit_user_path(current_user) if !current_user.admin? && @user != current_user
  end

  def update
    @user = User.find(params[:id])
    redirect_to edit_user_path(current_user) if !current_user.admin? && @user != current_user
    if params[:user] && (@user == current_user || current_user.admin?) 
      @user.email = params[:user][:email]
      @user.city_id = params[:user][:city_id]
      flash[:info] = "Данные обновлены"
      @user.save

      if params[:old_password] && !params[:old_password].blank? 
        if @user.update_password(params[:old_password], params[:user][:password], params[:user][:password_confirmation])
          flash[:info] = "Пароль успешно изменен"
        else
          flash[:info] = "Неверный пароль"
        end
      end
    end
    #render 'edit'
    #@user.update_attributes(params[:user]) #if @user == current_user || current_user.admin?
    redirect_to edit_user_path(@user)
  end

  def activate
    if (@user = User.load_from_activation_token(params[:id]))
      @user.activate!
      redirect_to(login_path, :notice => 'Активация прошла успешно')
    else
      not_authenticated
    end
  end
end
