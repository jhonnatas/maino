class RemoveIndexFromUsersColumn < ActiveRecord::Migration[7.0]
  def change
    remove_index :comments, :user_id
  end
end
