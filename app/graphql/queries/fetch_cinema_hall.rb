# frozen_string_literal: true

module Queries
  class FetchCinemaHall < Queries::BaseQuery
    type Types::CinemaHallType, null: false
    argument :id, ID, required: true

    def resolve(id:)
      CinemaHall.find(id)
    rescue ActiveRecord::RecordNotFound => _e
      GraphQL::ExecutionError.new('CinemaHall does not exist.')
    rescue ActiveRecord::RecordInvalid => e
      GraphQL::ExecutionError.new("Invalid attributes for #{e.record.class}:"\
                                  " #{e.record.errors.full_messages.join(', ')}")
    end
  end
end
