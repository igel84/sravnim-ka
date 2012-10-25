#encoding: utf-8
class SessionsController < ApplicationController
 def create
    user = login(params[:email], params[:password], params[:remember_me])
    if user
      redirect_back_or_to root_url, :notice => "Вы успешно вошли на сайт"
    else
      flash.now.alert = "Адрес электронной почты или пароль указаны не верно"
      render :new
    end
  end

  def destroy
    logout
    redirect_to root_url, :notice => "Вы успешно покинули сайт"
  end
end
