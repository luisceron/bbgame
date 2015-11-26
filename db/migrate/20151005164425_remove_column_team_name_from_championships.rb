class RemoveColumnTeamNameFromChampionships < ActiveRecord::Migration
  def change
  	remove_column :championships, :team_name
  end
end
