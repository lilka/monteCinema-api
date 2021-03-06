# frozen_string_literal: true

class CancelReservationJob < ApplicationJob
  queue_as :default

  def perform(reservation_id)
    reservation = Reservations::Repository.new.find(reservation_id)
    return if reservation.paid

    Reservation.transaction do
      Reservations::UseCases::Update.new(id: reservation.id, params: { status: 'cancel' }).call
      ReleaseSeats.new(reservation.id).call
    end

    ReservationCancellationMailer.with(reservation: reservation).cancellation_email.deliver
  end
end
