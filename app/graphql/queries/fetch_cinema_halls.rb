# frozen_string_literal: true

module Queries
  class FetchCinemaHalls < Queries::BaseQuery
    type [Types::CinemaHallType], null: false

    def resolve
      CinemaHall.all
    end
  end
end
