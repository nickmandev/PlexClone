class AddThumbnailToVideos < ActiveRecord::Migration[5.1]
  def change
    add_column :videos, :thumbnail_url, :string
  end
end
