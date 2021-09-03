# frozen_string_literal: true

class ReservationConfirmationMailer < ApplicationMailer
  def confirmation_email
    @reservation = params[:reservation]
    @seats_reservation = ReservationSeats::Repository.new.fetch_seats_for_reservation(@reservation.id)
    @user =  @reservation.user
    mail(to: @user.email, subject: 'MonteCinema - reservation confirmation')
  end
end
