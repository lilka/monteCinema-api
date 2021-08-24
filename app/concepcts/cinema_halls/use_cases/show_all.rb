# frozen_string_literal: true

module CinemaHalls
  module UseCases
    class ShowAll
      def initialize(repository: CinemaHallRepository.new)
        @repository = repository
      end

      def call
        @repository.all
      end
    end
  end
end
