class AddColumnUserNameToPredictions < ActiveRecord::Migration
  def change
  	add_column :predictions, :user_name, :string
  end
end
