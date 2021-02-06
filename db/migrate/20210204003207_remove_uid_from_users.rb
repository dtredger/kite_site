class RemoveUidFromUsers < ActiveRecord::Migration[6.1]
  # remove while not using token-based auth
  def change

    remove_index :users, name: 'index_users_on_uid_and_provider'
    remove_column :users, :uid
  end
end
