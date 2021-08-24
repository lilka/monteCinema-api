
module CinemaHalls
  module UseCases
    class Show
      def initialize(repository: CinemaHallRepository.new, id:)
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
