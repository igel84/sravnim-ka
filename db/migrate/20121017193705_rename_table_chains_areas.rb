class RenameTableChainsAreas < ActiveRecord::Migration
  def change
    rename_table :chains_areas, :areas_chains
  end
end
