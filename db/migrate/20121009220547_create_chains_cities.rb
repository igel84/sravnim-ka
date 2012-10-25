class CreateChainsCities < ActiveRecord::Migration
  def change
    create_table :chains_cities, id: false do |t|
      t.references :city
      t.references :chain

      t.timestamps
    end
  end
end
