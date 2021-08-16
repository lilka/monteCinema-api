# frozen_string_literal: true

class TicketsController < ApplicationController
  def generateTickets(_reservation_id, seats_amount)
    seats_amount.all do |_seat|
      ticket = Ticket.create!({ reservation_id: :reservation_id })
    end
  end
end
