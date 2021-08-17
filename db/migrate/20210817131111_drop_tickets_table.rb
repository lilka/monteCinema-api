# frozen_string_literal: true

class DropTicketsTable < ActiveRecord::Migration[6.1]
  def change
    drop_table :tickets
    drop_table :ticket_types
  end
end
