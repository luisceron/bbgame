class AddNumberRoundToRounds < ActiveRecord::Migration
  def change
    add_column :rounds, :number_round, :integer
  end
end
