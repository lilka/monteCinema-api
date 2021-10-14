# frozen_string_literal: true

module Types
  module Input
    class CinemaHallInputType < Types::BaseInputObject
      argument :name, String, required: true
      argument :number_of_seats, Integer, required: true
    end
  end
end
