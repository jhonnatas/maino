class SetDefaultValueToNil < ActiveRecord::Migration[7.0]
  def change
    change_column_default :comments, :user_id, from: "", to: nil
  end
end
