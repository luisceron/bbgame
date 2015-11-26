class AddFlagToTeams < ActiveRecord::Migration
  def change
    add_column :team_teams, :flag, :string
  end
end
