class RemoveNumberRoundPredRounds < ActiveRecord::Migration
  def change
  	remove_column :pred_rounds, :number_round
  end
end
