class ChangeUserRoleRelation < ActiveRecord::Migration[6.1]
  def change
    remove_column :roles, :user_id
    add_reference :users, :role

  end
end
