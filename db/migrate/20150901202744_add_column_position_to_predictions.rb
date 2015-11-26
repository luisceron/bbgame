class AddColumnPositionToPredictions < ActiveRecord::Migration
  def change
  	add_column :predictions, :position, :integer, default: 1
  end
end
