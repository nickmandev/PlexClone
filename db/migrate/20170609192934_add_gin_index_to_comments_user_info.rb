class AddGinIndexToCommentsUserInfo < ActiveRecord::Migration[5.1]
  def change
    add_index :comments, :user_info, using: :gin
  end
end
