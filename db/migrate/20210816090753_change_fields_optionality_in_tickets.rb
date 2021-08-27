# frozen_string_literal: true

class ChangeFieldsOptionalityInTickets < ActiveRecord::Migration[6.1]
  def change
    change_column_null(:tickets, :ticket_type_id, true)
    change_column_null(:tickets, :seat_id, true)
  end
end
