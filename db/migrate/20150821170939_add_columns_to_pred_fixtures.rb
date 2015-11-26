class AddColumnsToPredFixtures < ActiveRecord::Migration
  def change
  	add_column :pred_fixtures, :team1_name, :string
  	add_column :pred_fixtures, :team2_name, :string
  	add_column :pred_fixtures, :date, :date
  	add_column :pred_fixtures, :hour, :time
  end
end
