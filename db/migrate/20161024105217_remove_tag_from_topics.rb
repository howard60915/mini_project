class RemoveTagFromTopics < ActiveRecord::Migration[5.0]
  def change
  	remove_column :topics, :tag

  end
end
