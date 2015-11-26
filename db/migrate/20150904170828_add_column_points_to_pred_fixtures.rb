class AddColumnPointsToPredFixtures < ActiveRecord::Migration
  def change
  	add_column :pred_fixtures, :points, :integer, default: 0
  end
end
