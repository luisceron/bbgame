class RenameTeamIdForChampionships < ActiveRecord::Migration
  def change
  	rename_column :championships, :team_teams_id, :teams_id
  end
end
