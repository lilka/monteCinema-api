# frozen_string_literal: true

class ReservationCancellationMailer < ApplicationMailer
  def cancellation_email
    @reservation = params[:reservation]
    @seats_reservation = ReservationSeats::Repository.new.fetch_seats_for_reservation(@reservation.id)
    @user =  @reservation.user
    mail(to: @user.email, subject: 'MonteCinema - reservation cancellation')
  end

  private

  def find_user(user_id)
    Users::Repository.new.find(user_id)
  end
end
