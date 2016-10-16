class AddColStatusToTopic < ActiveRecord::Migration[5.0]
  def change
  	add_column :topics , :status , :string
  	add_column :comments , :status , :string
  end
end
