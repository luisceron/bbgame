class SetColumnDefaultPredFixtures < ActiveRecord::Migration
  def change
  	change_column :pred_fixtures, :done, :boolean, default: false
  	change_column :pred_fixtures, :out_of_date_time, :boolean, default: false
  end
end
