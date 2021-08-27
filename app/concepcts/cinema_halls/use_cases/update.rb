# frozen_string_literal: true

module CinemaHalls
  module UseCases
    class Update
      def initialize(id:, params:, repository: CinemaHallRepository.new)
        @id = id.to_i
        @repository = repository
        @params = params
      end

      def call
        raise "Cinema Hall with #{id} don't exist" if repository.find(id).present? == false
        repository.update(params, id)
       
      end

      private

      attr_reader :params, :repository, :id
    end
  end
end
