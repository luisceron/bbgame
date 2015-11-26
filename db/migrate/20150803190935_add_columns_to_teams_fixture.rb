class AddColumnsToTeamsFixture < ActiveRecord::Migration
  def change
    add_column :teams_fixtures, :result_team1, :integer
    add_column :teams_fixtures, :result_team2, :integer
  end
end
