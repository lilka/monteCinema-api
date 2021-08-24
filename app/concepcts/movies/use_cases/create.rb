# frozen_string_literal: true

module UseCases
  module Movie
    class Create
      def initialize(repository: Repositories::MovieRepository.new)
        @repository = repository
      end

      def call
        @repository.create!
      end
    end
  end
end
