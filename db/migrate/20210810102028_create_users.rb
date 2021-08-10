# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.references :role, null: false, foreign_key: true
      t.string :email
      t.string :password

      t.timestamps
    end
  end
end
