class ChangeTeamsTableName < ActiveRecord::Migration
  def self.up
  	rename_table :team_teams, :teams
  end

  def self.down
  	rename_table :teams, :team_teams
  end
end
