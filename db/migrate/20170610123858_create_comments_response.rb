class CreateCommentsResponse < ActiveRecord::Migration[5.1]
  def change
    create_table :comments_responses do |f|
      f.text :body
      f.integer :vote_up, default: 0
      f.integer :vote_down, default: 0
      f.jsonb :user_info, default: {}

      f.belongs_to :comment, index: true

      f.timestamps
    end
    add_index :comments_responses, :user_info, using: :gin
  end
end
