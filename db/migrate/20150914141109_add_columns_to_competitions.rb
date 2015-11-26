class AddColumnsToCompetitions < ActiveRecord::Migration
  def change
  	add_column :comp_competitions, :post, :boolean, default: false
  	add_column :comp_competitions, :started, :boolean, default: false
  end
end
