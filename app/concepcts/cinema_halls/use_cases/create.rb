# frozen_string_literal: true

module CinemaHalls
  module UseCases
    class Create
      def initialize(params:, repository: CinemaHallRepository.new)
        @repository = repository
        @params = params
      end

      def call
        repository.create(params) 
      end

      private

      attr_reader :params, :repository
    end
  end
end
