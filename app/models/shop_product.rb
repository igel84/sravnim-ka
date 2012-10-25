class ShopProduct < ActiveRecord::Base
	belongs_to :shop
	belongs_to :product

  before_save :add_raiting

  def add_raiting
    #
    #shop = 
    #self.shop.
  end

end
