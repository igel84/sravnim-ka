class CreateShopProducts < ActiveRecord::Migration
  def change
    create_table :shop_products do |t|
      t.integer :shop_id
      t.integer :product_id
      t.decimal :price
      t.string :name
      t.timestamps
    end
  end
end
