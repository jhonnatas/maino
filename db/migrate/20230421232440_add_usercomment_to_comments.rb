class AddUsercommentToComments < ActiveRecord::Migration[7.0]
  def change
    add_column :comments, :usercomment, :string
  end
end
