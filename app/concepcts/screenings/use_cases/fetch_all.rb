# frozen_string_literal: true

module Screenings
  module UseCases
    class FetchAll
      def initialize(repository: Screenings::Repository.new)
        @repository = repository
      end

      def call
        @repository.all
      end
    end
  end
end
