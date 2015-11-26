class AddColumnsToFixtures < ActiveRecord::Migration
  def change
    add_column :fixtures, :team1, :integer
    add_column :fixtures, :team2, :integer
    add_column :fixtures, :result_team1, :integer
    add_column :fixtures, :result_team2, :integer
  end
end
