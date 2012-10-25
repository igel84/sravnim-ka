class XmlFilesController < ApplicationController
  before_filter :require_login
  
  #skip_before_filter :require_login
  skip_before_filter :override_db
  require 'fileutils'
  require 'iconv'
  require 'roo'

  def create
    tmp = params[:xml_file][:attach].tempfile
    file = File.join("public", "#{(0...50).map{ ('a'..'z').to_a[rand(26)] }.join}.xls")
    FileUtils.cp tmp.path, file

    @price_list = []
    oo = Excel.new(file)
      oo.default_sheet = oo.sheets.first
      2.upto(50) do |line|
        product = oo.cell(line,'A')
        name = oo.cell(line,'B')
        volume = oo.cell(line,'C')        
        count = oo.cell(line,'D') 
        if !name.blank? && !product.blank? && !volume.blank? && !count.blank? && (prod = Product.find_by_name(product))
           
          price = Price.new
          price.product = prod.name
          price.product_id = prod.id
          price.name = name
          price.volume = volume
          price.count = count.to_s.gsub(',','.')

          @price_list << price
        end
      end
    FileUtils.rm file

    if params[:shop_id] && !params[:shop_id].blank?
      @type = 'shop'
      @shop_id = params[:shop_id]
      @area_id = params[:area_id]
      @city_id = params[:city_id]
      @chain_id = params[:chain_id]
    elsif params[:area_id] && !params[:area_id].blank?
      @type = 'area'
      @area_id = params[:area_id]
      @city_id = params[:city_id]
      @chain_id = params[:chain_id]
    elsif params[:city_id] && !params[:city_id].blank?
      @type = 'city'
      @city_id = params[:city_id]
      @chain_id = params[:chain_id]
    elsif params[:chain_id] && !params[:chain_id].blank?
      @type = 'chain'
      @chain_id = params[:chain_id]
    end

    #if params[:xml_file][:chain_id]
    #  chain = Chain.find(params[:xml_file][:chain_id])
    #  chain.shops.each do |shop|
    #    shop.shop_products.destroy_all
    #  end
    #  oo = Excel.new(file)
    #  oo.default_sheet = oo.sheets.first
    #  2.upto(20) do |line|
    #    product = oo.cell(line,'A')
    #    name = oo.cell(line,'B')
    #    price = oo.cell(line,'C')        
    #    if !name.blank? && !product.blank? && !price.blank? && (prod = Product.find_by_name(product))
    #      chain.shops.each do |shop|
    #        ShopProduct.create(shop_id: shop.id, name: name, product_id: prod.id, price: price)
    #      end
    #      @count += 1
    #    end
    #  end
    #elsif params[:xml_file][:shop_id]
    #  ShopProduct.where(shop_id: params[:xml_file][:shop_id]).destroy_all           
    #  oo = Excel.new(file)
    #  oo.default_sheet = oo.sheets.first
    #  2.upto(20) do |line|
    #    product = oo.cell(line,'A')
    #    name = oo.cell(line,'B')
    #    price = oo.cell(line,'C')        
    #    if !name.blank? && !product.blank? && !price.blank? && (prod = Product.find_by_name(product))
    #      ShopProduct.create(shop_id: params[:xml_file][:shop_id], name: name, product_id: prod.id, price: price)
    #      @count += 1
    #    end   
    #  end
    #end
    #FileUtils.rm file
  end

end