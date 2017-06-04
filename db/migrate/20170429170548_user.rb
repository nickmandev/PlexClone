class User < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |f|
      f.string :name
      f.string :email
      f.string :password

      f.timestamps
    end
  end
end
