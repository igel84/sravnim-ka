class CreateChains < ActiveRecord::Migration
  def change
    create_table :chains do |t|
      t.string :name

      t.string :logo_content_type
      t.integer :logo_file_size
      t.string :logo_file_name      
      t.datetime :logo_updated_at

      t.text :info
      t.string :site

      t.timestamps
    end
  end
end
