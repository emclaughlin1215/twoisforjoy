class AddTokenCreatedAtToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :token_created_at, :datetime
    remove_index :users, :token
    remove_index :users, :email
    add_index :users, [:token, :token_created_at, :email]
  end
end
