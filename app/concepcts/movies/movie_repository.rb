# frozen_string_literal: true

module Movies
  class MovieRepository
    attr_reader :adapter

    def initialize(adapter: Movie)
      @adapter = adapter
    end

    def all
      adapter.all
    end

    def find(id:)
      adapter.find(id)
    end

    def create!(params)
      adapter.create!(params)
    end
  end
end
