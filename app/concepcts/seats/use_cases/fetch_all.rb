# frozen_string_literal: true

module Seats
  module UseCases
    class FetchAll
      def initialize(params, repository: Seats::Repository.new)
        @repository = repository
        @params = params
      end

      def call
        repository.fetch_all_seats(params[:screening_id])
      end

      private

      attr_reader :repository, :params
    end
  end
end
