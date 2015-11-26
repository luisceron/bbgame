class AddForeignKeyToRounds < ActiveRecord::Migration
  def change
    add_column :rounds, :competition_id, :integer
    add_index  :rounds, :competition_id
  end
end
