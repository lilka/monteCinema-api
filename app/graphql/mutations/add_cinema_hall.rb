# frozen_string_literal: true

module Mutations
  class AddCinemaHall < Mutations::BaseMutation
    argument :params, Types::Input::CinemaHallInputType, required: true

    field :cinema_hall, Types::CinemaHallType, null: false

    def resolve(params:)
      cinema_hall_params = Hash params

      begin
        cinema_hall = CinemaHall.create!(cinema_hall_params)
        { cinema_hall: cinema_hall }
      rescue ActiveRecord::RecordInvalid => e
        GraphQL::ExecutionError.new("Invalid attributes for #{e.record.class}:"\
                                    " #{e.record.errors.full_messages.join(', ')}")
      end
    end
  end
end
