class AddIndexToUsers < ActiveRecord::Migration[5.1]
  def change
    add_index :users, :user_name, unique: true
    add_index :users, :email, unique: true
  end
end
