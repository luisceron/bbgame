class AddLocalToFixturesAndPredFixtures < ActiveRecord::Migration
  def change
  	add_column :fixtures, :local, :string
  	add_column :pred_fixtures, :local, :string
  end
end
