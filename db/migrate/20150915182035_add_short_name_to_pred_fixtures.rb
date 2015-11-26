class AddShortNameToPredFixtures < ActiveRecord::Migration
  def change
  	add_column :pred_fixtures, :short_name, :string
  end
end
