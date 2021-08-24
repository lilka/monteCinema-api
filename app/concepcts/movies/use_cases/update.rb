# frozen_string_literal: true

module Movies
  module UseCases
    class Update
      def initialize(id:, params:, repository: MovieRepository.new)
        @id = id
        @repository = repository
        @params = params
      end

      def call
        movie = repository.find(id: id)
        movie.update(params)
        movie
      end

      private

      attr_reader :params, :repository, :id
    end
  end
end
