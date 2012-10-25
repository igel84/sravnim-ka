class CreateDiscussions < ActiveRecord::Migration
  def change
    create_table :discussions do |t|
      t.string :title
      t.string :ancestry
      t.boolean :visible, default: false
      t.text :body
      t.integer :user_id
      t.integer :parent_id
      t.string :user_name

      t.timestamps
    end
    add_index :discussions, :ancestry
    add_index :discussions, :parent_id
  end
end
