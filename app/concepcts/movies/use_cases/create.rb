# frozen_string_literal: true

module Movies
  module UseCases
    class Create
      def initialize(params:, repository: MovieRepository.new)
        @repository = repository
        @params = params
      end

      def call
        repository.create!(params)
      end

      private

      attr_reader :params, :repository
    end
  end
end
