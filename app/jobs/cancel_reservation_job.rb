# frozen_string_literal: true

class CancelReservationJob < ApplicationJob
  queue_as :default

  def perform(reservation_id)
    reservation = Reservations::Repository.new.find(reservation_id)
    puts 'job is running'
    if reservation.paid == false
      Reservation.transaction do
        Reservations::UseCases::Update.new(id: reservation.id, params: { status: 'cancel' }).call
        FreeUpSeats.new(reservation.id).call
      end
    end
    puts reservation.status
  end
end
