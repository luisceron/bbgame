class AddColumnDoneToPredRounds < ActiveRecord::Migration
  def change
  	add_column :pred_rounds, :done, :boolean, default: false
  end
end
