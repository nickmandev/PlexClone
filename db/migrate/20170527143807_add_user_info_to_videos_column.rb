class AddUserInfoToVideosColumn < ActiveRecord::Migration[5.1]
  def change
    add_column :videos, :user_info, :string
  end
end
