class SetPointsDefaultValuePredictions < ActiveRecord::Migration
  def change
  	change_column :predictions, :points, :integer, default: 0
  end
end
