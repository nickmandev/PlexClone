class AddingVoteToVideoTable < ActiveRecord::Migration[5.1]
  def change
    add_column :videos, :vote_up, :integer
    add_column :videos, :vote_down, :integer
  end
end
