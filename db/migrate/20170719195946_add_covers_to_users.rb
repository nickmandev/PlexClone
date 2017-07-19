class AddCoversToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :covers_data, :text
  end
end
