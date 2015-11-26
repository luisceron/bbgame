class AddColumnsToPredFixtures2 < ActiveRecord::Migration
  def change
  	add_column :pred_fixtures, :out_of_date_time, :boolean
  end
end
