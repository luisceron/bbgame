class ChangeTypeColumnCompetitions < ActiveRecord::Migration
  def change
    remove_column :comp_competitions, :number_teams
    add_column :comp_competitions, :number_teams, :integer
  end
end
