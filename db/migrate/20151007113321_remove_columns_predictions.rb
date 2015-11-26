class RemoveColumnsPredictions < ActiveRecord::Migration
  def change
  	remove_column :predictions, :competition_name
  	remove_column :predictions, :user_name
  	remove_column :predictions, :number_rounds
  end
end
