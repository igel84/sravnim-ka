#encoding: utf-8
class UsersController < ApplicationController
  before_filter :require_login, :except => [:new, :create, :activate, :sign_with_social]

  def index
    redirect_to new_user_path  
  end

  def new
    @user = User.new
  end

  def create
    if params[:token]
      logger.info('social auth start')
      token = params[:token]
      app_id = "30025"
      secret_key = "8374210538983a539635429893ff2584"
      if !token.nil?
        social_data = Loginza.user_data(params[:token], :options => {:id => app_id, :sig => secret_key})
        email = social_data['email']
        logger.info(email)
          if !email.nil?
          user = User.find_by_email(email)
          if(user.nil?)
            user = User.new(:email => email,
                            #:provider => social_data['provider'],
                            :first_name => social_data['name']['first_name'],
                            :last_name => social_data['name']['last_name'],
                            #:nickname => social_data['nickname'],
                            :authentication_token => social_data['uid'],
                            :password => secret_key)
            #user.skip_confirmation!
            user.save
            user.activate!
          end
        sign_in user, :bypass => true
       end       
      end
      redirect_to root_url#, :notice => "Вы успешно зарегистрировались на сайте"
    else
      @user = User.new(params[:user])
      if @user.save
        if params[:photo_price]
          @photo_price = PhotoPrice.find(params[:photo_price])
          @photo_price.update_attributes(user_id: @user.id) if @photo_price.user_id == nil
        end
        redirect_to root_url, :notice => "Вы успешно зарегистрировались на сайте"
      else
        render :new
      end
    end
  end

  def sign_with_social
    token = params[:token]  #достаем токен из запроса
    if !token.nil?
     
      #выполняем удаленный запрос на сайт ulogin
      require 'net/http'
      url = URI.parse('http://ulogin.ru/token.php?token='+token) 
      
      #парсим полученные данные
      social_data = ActiveSupport::JSON.decode(Net::HTTP.get(url))
      uid = social_data['identity']
      email = social_data['email']
      first_name = social_data['first_name']
      last_name = social_data['last_name']
      
      #Ищем пользователя по email
      @user = User.find_by_email(email)
      if @user.nil?
        
        #Если пользователь с email не найден, то ищем пользователя по по уникальному id    пользователя на социальном ресурсе
        @user = User.find_by_authentication_token(uid)
        my_time = Time.now
        
        #Если пользователь не найден, то создаем нового с параметрами как в соц сети
        if @user.nil?
          @user = User.new
          @user.email=email
          @user.password="password"
          @user.authentication_token=uid
          @user.first_name=first_name
          @user.last_name=last_name
          #@user.skip_confirmation! #необходим для того, чтобы сообщение о подтверждении авторизации не высылалось по email
          @user.save
          @user.activate!
        end
      end
      #авторизируем найденного или нового созданного пользователя в системе
      sign_in @user, :bypass => true
      redirect_to root_path
    end
  end

  def edit
    @user = User.find(params[:id])
    @users = User.all if current_user && current_user.admin?
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

  def destroy
    User.find(params[:id]).destroy if current_user.admin?
    redirect_to edit_user_path(current_user)
  end

  def activate
    if (@user = User.load_from_activation_token(params[:id]))
      @user.activate!
      current_user = @user      
      redirect_to edit_user_path(current_user) #(login_path, :notice => 'Активация прошла успешно')
    else
      not_authenticated
    end
  end
end
