# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    # TODO: remove me
    field :add_cinema_hall, mutation: Mutations::AddCinemaHall
  end
end
