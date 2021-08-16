# frozen_string_literal: true

class AddUserToRoles < ActiveRecord::Migration[6.1]
  def change
    add_reference :roles, :user, null: false, foreign_key: true
  end
end
