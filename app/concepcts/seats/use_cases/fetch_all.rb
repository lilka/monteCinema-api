# frozen_string_literal: true

module Seats
  module UseCases
    class FetchAll
      def initialize(params, repository: Screenings::Repository.new)
        @repository = repository
        @params = params
      end

      def call
        repository.fetch_all_seats(params[:sereening_id])
      end

      private

      attr_reader :repository, :params
    end
  end
end
