class AddNumberRoundsToCompetitions < ActiveRecord::Migration
  def change
  	add_column :comp_competitions, :number_rounds, :integer
  	add_column :predictions, :number_rounds, :integer
  end
end
