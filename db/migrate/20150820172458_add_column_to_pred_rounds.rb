class AddColumnToPredRounds < ActiveRecord::Migration
  def change
  	add_column :pred_rounds, :prediction_id, :integer
  	add_index :pred_rounds, :prediction_id
  end
end
