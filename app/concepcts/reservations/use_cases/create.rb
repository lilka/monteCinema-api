# frozen_string_literal: true

module Reservations
  module UseCases
    class Create
      SeatsNotValidError = Class.new(StandardError)
      def initialize(params:, repository: Reservations::Repository.new)
        @repository = repository
        @params = params
        @seat_ids = seats_to_array(params[:seat_ids])
      end

      def call
        if ReservationSeats::Validator.new(
          seat_ids, params[:screening_id]
        ).valid? == false
          raise SeatsNotValidError,
                'Seats with given ids are not valid or there is not enough free seats'
        end

        Reservation.transaction do
          @reservation = repository.create!({ status: 'pending', paid: false, screening_id: params[:screening_id],
                                              user_id: params[:user_id] })
          AssignSeats.new(@reservation.id, seat_ids, params[:screening_id]).call
        end
        @reservation
      end

      private

      attr_reader :params, :repository, :seat_ids

      def seats_to_array(seat_ids)
        seat_ids.map(&:to_i)
      end
    end
  end
end
