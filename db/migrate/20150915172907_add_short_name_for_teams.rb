class AddShortNameForTeams < ActiveRecord::Migration
  def change
  	add_column :team_teams, :short_name, :string, limit: 3
  end
end
