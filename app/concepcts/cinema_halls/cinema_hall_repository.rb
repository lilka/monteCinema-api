
module CinemaHalls
  class CinemaHallRepository
    attr_reader :adapter

    def initialize(adapter: CinemaHall)
      @adapter = adapter
    end

    def all
      adapter.all
    end

    def find(id:)
      adapter.find(id)
    end

    def create(params)
      adapter.create(params)
    end
  end
end
