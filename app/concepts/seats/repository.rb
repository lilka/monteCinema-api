# frozen_string_literal: true

module Seats
  class Repository
    attr_reader :adapter

    def initialize(adapter: Seat)
      @adapter = adapter
    end

    def all
      adapter.all
    end

    def find(id)
      adapter.find(id)
    end

    def fetch_all_seats(screening_id)
      adapter.select(:id, :row, :number).joins(:screening).where('seats.screening_id = ?',
                                                                 screening_id).order('row, number')
    end

    def fetch_seat(screening_id, id)
      adapter.select(:id, :row, :number).joins(:screening).where('seats.screening_id = ? and seats.id = ?',
                                                                 screening_id, id).first
    end
  end
end
