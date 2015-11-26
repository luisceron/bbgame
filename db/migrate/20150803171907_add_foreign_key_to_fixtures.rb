class AddForeignKeyToFixtures < ActiveRecord::Migration
  def change
    add_column :fixtures, :round_id, :integer
    add_index  :fixtures, :round_id
  end
end
