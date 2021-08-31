# frozen_string_literal: true

module CinemaHalls
  module UseCases
    class Show
      def initialize(id:, repository: CinemaHalls::Repository.new)
        @repository = repository
        @id = id
      end

      def call
        @repository.find(id: id)
      end

      private

      attr_reader :id, :repository
    end
  end
end
