class AddTimestampsToVideos < ActiveRecord::Migration[5.1]
  def change
    add_column :videos, :created_at, :datetime
    add_column :videos, :view_count, :integer
  end
end
