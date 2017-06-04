class CreateVideosTable < ActiveRecord::Migration[5.1]
  def change
    create_table :videos do |t|
      t.text :video_data
      t.belongs_to :user, index: true
    end
  end
end
