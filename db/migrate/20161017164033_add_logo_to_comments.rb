class AddLogoToComments < ActiveRecord::Migration[5.0]
  def up
    add_attachment :comments, :logo
  end

  def down
    remove_attachment :comments, :logo
  end
end
