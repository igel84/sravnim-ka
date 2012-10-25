#encoding: utf-8
class Role < ActiveRecord::Base
  establish_connection "production"  
  
  has_and_belongs_to_many :users, :join_table => :users_roles
  belongs_to :resource, :polymorphic => true
  
  scopify

  def alias
     case self.name
     when 'seller'
      Chain.find(self.resource_id).name 
     when 'city'
      City.find(self.resource_id).alias
    when 'area'
      area = Area.find(self.resource_id)
      return City.find(area.city_id).alias + ' - ' + area.name
     when 'shop'
      shop = Shop.find(self.resource_id)
      area = Area.find(shop.area_id)
      return City.find(area.city_id).alias + ' - ' + area.name + ' - ' + shop.adds
     end     
  end

end
