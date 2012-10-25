# encoding: utf-8

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#User.destroy_all
#City.destroy_all

#cities = City.create([{ name: 'Воронеж' }, { name: 'Москва' }])
#user = User.new(
#  email:'admin@mlip.ru', 
#  password:'111111',
#  password_confirmation:'111111',
#  admin:true,
#  city_id:City.find_by_name('Воронеж').id)
#user.save

#user.activate!

@cities = City.all
@chains = Chain.all
@products = Product.all

ActiveRecord::Base.clear_cache!
ActiveRecord::Base.establish_connection(
    adapter: 'sqlite3',
    database: 'db/old_development.sqlite3',
    pool: 5,
    timeout: 5000
)

@areas = Area.all
@areas.each do |area|
    next if area.city_id == nil
    ActiveRecord::Base.clear_cache!
    ActiveRecord::Base.establish_connection(
        adapter: 'sqlite3',
        database: "db/#{City.find(area.city_id).name}.sqlite3",
        pool: 5,
        timeout: 5000
    )
    Area.create(city_id: area.city_id, name: area.name)
end

#Shop.destroy_all(chain_id: 1)
#Shop.destroy_all(chain_id: 2)
#Shop.destroy_all(chain_id: 3)

#@cities.each do |city|
#  if city.id == 1 || city.id == 2
#    city.chains = []
#    city.save
#
#    ActiveRecord::Base.clear_cache!
#    ActiveRecord::Base.establish_connection(
#        adapter: 'sqlite3',
#        database: "db/#{city.name}.sqlite3",
#        pool: 5,
#        timeout: 5000
#    )
    
#    @chains.each do |chain|
#      if Shop.where(chain_id: chain.id).first
#        city.chains << chain        
#      end
#    end

#    ActiveRecord::Base.clear_cache!
#    ActiveRecord::Base.establish_connection(
#        adapter: 'sqlite3',
#        database: "db/development.sqlite3",
#        pool: 5,
#        timeout: 5000
#    )
#    city.save

#  end
#end

#ActiveRecord::Base.clear_cache!
#ActiveRecord::Base.establish_connection(
#    adapter: 'sqlite3',
#    database: 'db/voronezh.sqlite3',
#    pool: 5,
#    timeout: 5000
#)      

#1.upto(5) do |i|
#  Area.create(name: "Район города № #{i.to_s}", city_id: 1)
#end
      
#@chains.each do |chain|
#  1.upto(5) do |i|
#    area_id = rand(Area.all.count)
#    area_id += 1 if area_id == 0
#    adds = 'адрес магазина ' + i.to_s
#    Shop.create(chain_id: chain.id, area_id: area_id, adds: adds, name: chain.name, raiting: rand(300))
#  end
#end

#Shop.all.each do |shop|
#  @products.each do |prod|
#    1.upto(2) do |i|
#      name = 'продовольственный товар № ' + i.to_s
#      ShopProduct.create(product_id: prod.id, shop_id: shop.id, price: rand(1000), name: name)
#    end
#  end
#end

#Shop.all.each do |shop|
#  shop.set_raiting
#end