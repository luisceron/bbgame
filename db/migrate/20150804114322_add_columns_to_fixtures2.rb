class AddColumnsToFixtures2 < ActiveRecord::Migration
  def change
    add_column :fixtures, :team1_name, :string
    add_column :fixtures, :team2_name, :string
  end
end
