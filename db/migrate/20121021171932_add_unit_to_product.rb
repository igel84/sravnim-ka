class AddUnitToProduct < ActiveRecord::Migration
  def change
    add_column :products, :unit, :string, default: ''
  end
end
