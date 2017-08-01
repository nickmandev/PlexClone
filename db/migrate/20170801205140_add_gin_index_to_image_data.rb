class AddGinIndexToImageData < ActiveRecord::Migration[5.1]
  def up
    remove_column :users, :image_data, :text
    add_column :users, :image_data, :jsonb, default: {}
    add_index :users, :image_data, using: :gin
  end

  def down 
    remove_index :users, :image_data
    remove_column :users, :image_data, :jsonb
    add_column :users, :image_data, :text
  end
end
