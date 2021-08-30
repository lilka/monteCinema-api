# frozen_string_literal: true

module Screenings
  module UseCases
    class Create
      def initialize(params:, repository: ScreeningRepository.new)
        @repository = repository
        @params = params
      end

      def call
        Screening.transaction do
          @screening = repository.create!(params)
          GenerateSeats.new(params[:cinema_hall_id], @screening.id).call
        end
        @screening
      end

      private

      attr_reader :params, :repository
    end
  end
end
