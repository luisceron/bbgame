class AddFilledToPredFixtures < ActiveRecord::Migration
  def change
  	add_column :pred_fixtures, :filled, :boolean, default: false
  end
end
