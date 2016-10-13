class FixViewsToTopic < ActiveRecord::Migration[5.0]
  def change
  	remove_column :topics , :views 
  	add_column :topics , :views ,:integer , :default => 0
  end
end
