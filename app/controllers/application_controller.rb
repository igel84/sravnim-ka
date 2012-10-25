#encoding: utf-8
class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :show_promotion
  before_filter :override_db
  before_filter :check_city

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end
  
  def not_authenticated
    redirect_to main_app.login_path, :alert => "Сначала войдите на сайт или зарегистрируйтесь"
  end

  def check_city
    @city = City.find(session['city']) if session['city']
  end

  private
    def show_promotion
      @active_promotions = Promotion.all(conditions: {active: true}, order: 'balance DESC, id', limit: 3)
      @active_promotions.shuffle!
      count = @active_promotions.count
      @active_promotions += Promotion.all(conditions: {user_id: 1}, limit: 3 - count) if count < 3
      @active_promotions.each do |promo|
        promo.balance -= 1
        promo.active, promo.balance = false, 0 if promo.balance <= 0
        promo.save
      end
    end

    # Собственно сам метод переключения 
    def override_db
      @current_city = City.find_by_name(request.subdomain) 
      @current_city = City.find(params[:city_id]) if params[:city_id] #&& @current_city.nil?
      @products = Product.all
      @users = User.all
      @chains = Chain.all
      #not_found unless @current_city

      if @current_city
        ActiveRecord::Base.clear_cache!
        ActiveRecord::Base.establish_connection(
            adapter: 'sqlite3',
            database: "db/#{@current_city.name}.sqlite3",
            pool: 5,
            timeout: 5000
        )      
      elsif current_user
        #
      elsif request.subdomain == 'sravnim-ka'
        #
      else
        #redirect_to root_url
      end    
    end

end
