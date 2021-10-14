# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField
    field :fetch_cinema_halls, resolver: Queries::FetchCinemaHalls
    field :fetch_cinema_hall, resolver: Queries::FetchCinemaHall
  end
end
