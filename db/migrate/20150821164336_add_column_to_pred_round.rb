class AddColumnToPredRound < ActiveRecord::Migration
  def change
  	add_column :pred_rounds, :number_round, :integer
  end
end
