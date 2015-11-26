class RenameColumnChampionships < ActiveRecord::Migration
  def change
  	rename_column :championships, :teams_id, :team_id
  end
end
