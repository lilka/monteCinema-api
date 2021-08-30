# frozen_string_literal: true

module Reservations
  module UseCases
    class ShowAll
      def initialize(repository: ReservationRepository.new)
        @repository = repository
      end

      def call
        @repository.all
      end
    end
  end
end
