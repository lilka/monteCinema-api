# frozen_string_literal: true

class CreateTicketTypes < ActiveRecord::Migration[6.1]
  def change
    create_table :ticket_types do |t|
      t.string :name
      t.decimal :price

      t.timestamps
    end
  end
end
