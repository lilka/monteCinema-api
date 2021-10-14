# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField
    field :cinemaHall,
      [Types::CinemaHallType], 
      null: false, 
      description: "Returns list of CinemaHalls in the MonteCinema liblary"

      def cinemaHall
        CinemaHall.all
      end
  end
end
