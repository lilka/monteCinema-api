# frozen_string_literal: true

module Seats
  module UseCases
    class Fetch
      def initialize(params, repository: Seats::Repository.new)
        @repository = repository
        @params = params
      end

      def call
        repository.fetch_seat(params[:screening_id], params[:id])
      end

      private

      attr_reader :repository, :params
    end
  end
end
