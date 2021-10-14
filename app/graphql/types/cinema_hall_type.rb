# frozen_string_literal: true

module Types
  class CinemaHallType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :number_of_seats, Integer, null: true
  end
end
