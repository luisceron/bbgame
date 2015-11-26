class AddFieldsToFixtures < ActiveRecord::Migration
  def change
    add_column :fixtures, :date, :date
    add_column :fixtures, :hour, :time
  end
end
