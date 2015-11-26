class ChangeColumnsNameFromPredictions < ActiveRecord::Migration
  def change
  	rename_column :predictions, :comp_competitions_id, :competition_id
  	rename_column :predictions, :users_id, :user_id
  end
end
