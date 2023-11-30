class ChangeUserRoleToEnum < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :role
    remove_column :users, :role_enum
    add_column :users, :role, :integer
  end
end
