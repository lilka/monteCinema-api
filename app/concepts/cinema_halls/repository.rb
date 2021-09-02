# frozen_string_literal: true

module CinemaHalls
  class Repository
    attr_reader :adapter

    def initialize(adapter: CinemaHall)
      @adapter = adapter
    end

    def all
      adapter.all
    end

    def find(id)
      adapter.find(id)
    end

    def create!(params)
      adapter.create!(params)
    end

    def update(params, id)
      adapter.find_by(id: id).update(params)
    end
  end
end
