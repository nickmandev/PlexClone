class CommentsTable < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |f|
      f.text :body
      f.integer :vote_up, default: 0
      f.integer :vote_down, default: 0

      f.belongs_to :video, index: true

      f.timestamps
    end
  end
end
