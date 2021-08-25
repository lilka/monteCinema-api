# frozen_string_literal: true

module CinemaHalls
  module UseCases
    class Update
      def initialize(id:, params:, repository: CinemaHallRepository.new)
        @id = id
        @repository = repository
        @params = params
      end

      def call
        cineam_hall = repository.find(id: id)
        cineam_hall.update(params)
        cineam_hall
      end

      private

      attr_reader :params, :repository, :id
    end
  end
end
