class AddAvatarToComments < ActiveRecord::Migration[5.0]
  def up
    add_attachment :comments, :avatar
  end

  def down
    remove_attachment :comments, :avatar
  end
end
