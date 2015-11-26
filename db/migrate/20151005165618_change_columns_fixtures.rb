class ChangeColumnsFixtures < ActiveRecord::Migration
  def change
  	rename_column :fixtures, :team1, :team1_id
  	rename_column :fixtures, :team2, :team2_id
  end
end
