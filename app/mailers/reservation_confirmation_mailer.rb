# frozen_string_literal: true

class ReservationConfirmationMailer < ApplicationMailer
  def confirmation_email
    @reservation = params[:reservation]
    @user =  @reservation.user
    mail(to: @user.email, subject: 'MonteCinema - reservation confirmation')
  end

  private

  def find_user(user_id)
    Users::Repository.new.find(user_id)
  end
end
