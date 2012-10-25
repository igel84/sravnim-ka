class CreateXmlFiles < ActiveRecord::Migration
  def change
    create_table :xml_files do |t|

      t.integer :shop_id
      t.string :attach_content_type
      t.integer :attach_file_size
      t.string :attach_file_name      
      t.datetime :attach_updated_at

      t.timestamps
    end
  end
end
