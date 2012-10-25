#encoding: utf-8
class PricesController < ApplicationController
  include ActionView::Helpers::UrlHelper
  include ActionView::Helpers::NumberHelper
  include PricesHelper

  skip_before_filter :show_promotion, only: :index

  skip_before_filter :require_login, :only => :index
  skip_before_filter :override_db, :only => :index

  

  def index
    if params[:ids]
      @prices = ''
      Product.all.each do |product|  
        @prices += '<tr><td><a href="/products/'+ product.id.to_s + '">' + product.name + '</a></td>'
        params[:ids].each do |key, val|
          @prices += '<td style="text-align:center;cursor:pointer;cursor:hand;" rel="popover" data-content="' + include_all_price(key, product.id) + '" data-original-title="' + product.name + '" class="popover-text">' + number_to_currency(ShopProduct.where(shop_id: key, product_id: product.id).minimum(:price) || '0', unit: 'p.', separator: ',', format: "%n%u") + '</td>' unless key.nil?
        end
        @prices += '</tr>'          
      end

      #@prices = params[:ids]
    end
    #render 'index'
  end

  def create
    redirect_to edit_user_path if !current_user.admin?
    
    @price_list = []
    params[:price].each do |key, val|
      price = Price.new        
      key.each do |key, val|
        price.product_id = val if key == 'product_id'
        price.name = val if key == 'name'
        price.volume = val if key == 'volume'
        price.count = val.gsub(',','.') if key == 'count'        
      end
      @price_list << price
    end

    @shop = 0

    if params[:city_id] && !params[:city_id].blank?
      @current_city = City.find(params[:city_id])
      ActiveRecord::Base.clear_cache!
      ActiveRecord::Base.establish_connection(
          adapter: 'sqlite3',
          database: "db/#{@current_city.name}.sqlite3",
          pool: 5,
          timeout: 5000
      )
      # on SHOP
      if params[:shop_id] && !params[:shop_id].blank? && params[:type] == 'shop'
        #set real price to shop
        Shop.find(params[:shop_id]).update_attribute(:real_price, true)
        
        @price_list.each do |price|
          sh_pr = ShopProduct.where(shop_id: params[:shop_id], product_id: price.product_id, name: price.name).first
          if sh_pr
            sh_pr.destroy if price.count == '-'
            if price.count != '-'
              sh_pr.volume = price.volume
              sh_pr.price = price.count
              sh_pr.save 
            end 
          else
            ShopProduct.create(shop_id: params[:shop_id], product_id: price.product_id, name: price.name, price: price.count, volume: price.volume)
          end
        end
        Shop.find(params[:shop_id]).set_raiting
        
      # on AREA
      elsif params[:area_id] && !params[:area_id].blank? && params[:type] == 'area'
        Shop.where(area_id: params[:area_id], chain_id: params[:chain_id]).each do |shop|
          @price_list.each do |price|
            sh_pr = ShopProduct.where(shop_id: shop.id, product_id: price.product_id, name: price.name).first
            if sh_pr
              sh_pr.destroy if price.count == '-'
              if price.count != '-'
                sh_pr.price = price.count
                sh_pr.save 
              end 
            else
              ShopProduct.create(shop_id: shop.id, product_id: price.product_id, name: price.name, price: price.count, volume: price.volume)
            end
          end
          shop.set_raiting
        end
      # on CITY
      elsif  params[:city_id] && !params[:city_id].blank? && params[:type] == 'city'
        Shop.where(chain_id: params[:chain_id]).each do |shop|
          @price_list.each do |price|
            sh_pr = ShopProduct.where(shop_id: shop.id, product_id: price.product_id, name: price.name).first
            if sh_pr
              sh_pr.destroy if price.count == '-'
              if price.count != '-'
                sh_pr.price = price.count
                sh_pr.save 
              end 
            else
              ShopProduct.create(shop_id: shop.id, product_id: price.product_id, name: price.name, price: price.count, volume: price.volume)
            end
          end
          shop.set_raiting
        end 
      end
    #on CHAIN
    elsif params[:chain_id] && !params[:chain_id].blank? && params[:type] == 'chain'
      City.all.each do |city|
        next unless city.id == 1 || city.id == 2
        ActiveRecord::Base.clear_cache!
        ActiveRecord::Base.establish_connection(
            adapter: 'sqlite3',
            database: "db/#{city.name}.sqlite3",
            pool: 5,
            timeout: 5000
        )
        Shop.where(chain_id: params[:chain_id]).each do |shop|
          @price_list.each do |price|
            sh_pr = ShopProduct.where(shop_id: shop.id, product_id: price.product_id, name: price.name).first
            if sh_pr
              sh_pr.destroy if price.count == '-'
              if price.count != '-'
                sh_pr.price = price.count
                sh_pr.save 
              end 
            else
              ShopProduct.create(shop_id: shop.id, product_id: price.product_id, name: price.name, price: price.count, volume: price.volume)
            end
          end         
        end
      end
    end

    render js: "$('.close-btn').click();alert('информация успешно обновлена');"
  end

end