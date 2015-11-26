class AddPointsColumnToPredictions < ActiveRecord::Migration
  def change
  	add_column :predictions, :points, :integer
  end
end
