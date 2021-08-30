# frozen_string_literal: true

module Screenings
  class ScreeningRepository
    attr_reader :adapter

    def initialize(adapter: Screening)
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
      adapter.where(id: id).update(params).first
    end
  end
end
