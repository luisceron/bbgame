class RemoveColumnsPredFixtures < ActiveRecord::Migration
  def change
  	remove_column :pred_fixtures, :team1_name
  	remove_column :pred_fixtures, :team2_name
  	remove_column :pred_fixtures, :date
  	remove_column :pred_fixtures, :hour
  	remove_column :pred_fixtures, :done
  	remove_column :pred_fixtures, :pred_final_result_team1
  	remove_column :pred_fixtures, :pred_final_result_team2
  	remove_column :pred_fixtures, :local
  	remove_column :pred_fixtures, :team1_short_name
  	remove_column :pred_fixtures, :team2_short_name
  end
end
