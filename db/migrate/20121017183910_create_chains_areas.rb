class CreateChainsAreas < ActiveRecord::Migration
  def change
    create_table :chains_areas, id: false do |t|
      t.references :area
      t.references :chain

      t.timestamps
    end
  end
end