# frozen_string_literal: true

module Movies
  module UseCases
    class Delete
      def initialize(movie_id: movie_id, repository: MovieRepository.new)
        @repository = repository
        @movie_id = movie_id
      end

      def call
        movie = repository.find(id: movie_id)
        repository.delete(movie)
      end

      private

      attr_reader :movie_id, :repository
    end
  end
end
