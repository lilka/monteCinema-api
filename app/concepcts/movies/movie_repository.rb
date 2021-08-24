# frozen_string_literal: true

module Movies
  class MovieRepository
    attr_reader :adapter

    def initialize(adapter: Movies::Model)
      @adapter = adapter
    end

    def all
      adapter.all
    end

    def find(id:)
      adapter.find(id)
    end
  end
end
