class RenameCompetitionIdForChampionships < ActiveRecord::Migration
  def change
  	rename_column :championships, :comp_competitions_id, :competition_id
  end
end
