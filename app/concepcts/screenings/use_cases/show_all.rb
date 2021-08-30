# frozen_string_literal: true

module Screenings
  module UseCases
    class ShowAll
      def initialize(repository: ScreeningRepository.new)
        @repository = repository
      end

      def call
        @repository.all
      end
    end
  end
end
