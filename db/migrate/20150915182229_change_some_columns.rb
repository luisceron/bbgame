class ChangeSomeColumns < ActiveRecord::Migration
  def change
  	rename_column :pred_fixtures, :short_name, :team1_short_name
  	add_column :pred_fixtures, :team2_short_name, :string
  	add_column :fixtures, :team1_short_name, :string
  	add_column :fixtures, :team2_short_name, :string
  end
end
