class AddRealPriceToShop < ActiveRecord::Migration
  def change
    add_column :shops, :real_price, :boolean, default: false
  end
end
