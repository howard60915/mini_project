class CreateTopicTagships < ActiveRecord::Migration[5.0]
  def change
    create_table :topic_tagships do |t|
      t.integer :topic_id
      t.integer :tag_id
      t.timestamps
    end
    add_index :topic_tagships, :topic_id
    add_index :topic_tagships, :tag_id
  end
end
