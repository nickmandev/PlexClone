class AddingDefaultValueToVideoVote < ActiveRecord::Migration[5.1]
  def change
    remove_column :videos, :vote_up, :integer
    remove_column :videos, :vote_down, :integer
    add_column :videos, :vote_up, :integer, default: 0
    add_column :videos, :vote_down, :integer, default: 0
  end
end
