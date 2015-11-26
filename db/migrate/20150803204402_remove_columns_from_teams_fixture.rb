class RemoveColumnsFromTeamsFixture < ActiveRecord::Migration
  def change
    remove_column :teams_fixtures, :result_team1
    remove_column :teams_fixtures, :result_team2
  end
end
