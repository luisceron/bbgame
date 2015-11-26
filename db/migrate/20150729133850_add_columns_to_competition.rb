class AddColumnsToCompetition < ActiveRecord::Migration
  def change
    add_column :comp_competitions, :number_teams, :string
    add_column :comp_competitions, :place, :string
  end
end
