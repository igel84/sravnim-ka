class CreatePhotoPrices < ActiveRecord::Migration
  def change
    create_table :photo_prices do |t|
      t.references :user
      t.boolean :read, default: false
      t.boolean :assign, default: false
      t.string :user_comment
      t.string :admin_comment
      
      t.string :photo_content_type
      t.integer :photo_file_size
      t.string :photo_file_name      
      t.datetime :photo_updated_at

      t.timestamps
    end
  end
end
