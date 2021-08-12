# frozen_string_literal: true

class DropUsers < ActiveRecord::Migration[6.1]
  def up
    remove_reference :reservations, :user, null: false, foreign_key: true
    drop_table :users
  end

  def down; end
end
