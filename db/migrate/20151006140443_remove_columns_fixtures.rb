class RemoveColumnsFixtures < ActiveRecord::Migration
  def change
  	remove_column :fixtures, :team1_name
  	remove_column :fixtures, :team2_name
  	remove_column :fixtures, :team1_short_name
  	remove_column :fixtures, :team2_short_name
  end
end
