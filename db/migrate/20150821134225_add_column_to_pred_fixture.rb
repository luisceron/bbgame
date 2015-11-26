class AddColumnToPredFixture < ActiveRecord::Migration
  def change
  	add_column :pred_fixtures, :fixture_id, :integer
  	add_index :pred_fixtures, :fixture_id
  end
end
