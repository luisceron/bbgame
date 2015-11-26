class SetDefaultForDoneInRoundAndFixture < ActiveRecord::Migration
  def change
  	change_column :rounds, :done, :boolean, default: false
  	change_column :fixtures, :done, :boolean, default: false
  end
end
