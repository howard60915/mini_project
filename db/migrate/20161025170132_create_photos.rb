class CreatePhotos < ActiveRecord::Migration[5.0]
  def change
    create_table :photos do |t|
      t.string :image
      t.attachment :image
      t.integer :topic_id
      t.timestamps
    end
    add_index :photos, :topic_id
  end
end
