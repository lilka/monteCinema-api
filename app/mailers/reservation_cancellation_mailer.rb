# frozen_string_literal: true

class ReservationCancellationMailer < ApplicationMailer
  def cancellation_email
    @reservation = params[:reservation]
    @user =  @reservation.user
    mail(to: @user.email, subject: 'MonteCinema - reservation cancellation')
  end
end
