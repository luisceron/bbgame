class AddColumnsToPredRound < ActiveRecord::Migration
  def change
  	add_column :pred_rounds, :round_id, :integer
  	add_index :pred_rounds, :round_id
  end
end
