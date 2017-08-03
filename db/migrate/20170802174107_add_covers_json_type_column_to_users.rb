class AddCoversJsonTypeColumnToUsers < ActiveRecord::Migration[5.1]
  def up
    remove_column :users, :covers_data, :text
    add_column :users, :covers_data, :jsonb, default: {}
    add_index :users, :covers_data, using: :gin
  end

  def down 
    remove_index :users, :covers_data
    remove_column :users, :covers_data, :jsonb
    add_column :users, :covers_data, :text
  end
end
