class CreatePromotions < ActiveRecord::Migration
  def change
    create_table :promotions do |t|

      t.string :banner_content_type
      t.integer :banner_file_size
      t.string :banner_file_name      
      t.datetime :banner_updated_at

      t.string :name
      t.string :link
      t.string :info
      t.string :key
      t.integer :user_id
      t.integer :count, default: 0
      t.integer :balance, default: 0
      t.boolean :active, default: false

      t.timestamps
    end
  end
end
