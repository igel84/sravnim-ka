class AddVolumeToShopProduct < ActiveRecord::Migration
  def change
    add_column :shop_products, :volume, :integer, default: 0
  end
end
