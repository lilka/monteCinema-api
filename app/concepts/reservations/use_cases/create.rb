# frozen_string_literal: true

module Reservations
  module UseCases
    class Create
      SeatsNotValidError = Class.new(StandardError)
      CANCELLATION_PERIOD = 30.minutes
      def initialize(params:, repository: Reservations::Repository.new)
        @repository = repository
        @params = params
      end

      def call
        unless ReservationSeats::Validator.new(params).valid?
          raise SeatsNotValidError,
                'Seats with given ids are not valid or there is not enough free seats'
        end
        Reservation.transaction do
          @reservation = repository.create!({ status: 'pending', paid: false, screening_id: params[:screening_id],
                                              user_id: params[:user_id] })
          AssignSeats.new(@reservation.id, params).call
        end
        ReservationConfirmationMailer.with(reservation: @reservation).confirmation_email.deliver_later
        CancelReservationJob.set(wait_until: cancellation_time).perform_later(@reservation.id)
        @reservation
      end

      private

      attr_reader :params, :repository

      def cancellation_time
        @reservation.screening.start_time - CANCELLATION_PERIOD
      end
    end
  end
end
