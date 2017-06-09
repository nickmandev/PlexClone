class AddUserInfoToComments < ActiveRecord::Migration[5.1]
  def change
    add_column :comments, :user_info, :jsonb, default: {}
  end
end
