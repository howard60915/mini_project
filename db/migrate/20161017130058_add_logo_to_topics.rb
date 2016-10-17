class AddLogoToTopics < ActiveRecord::Migration[5.0]
  def up
    add_attachment :topics, :logo
  end

  def down
    remove_attachment :topics, :logo
  end
end
