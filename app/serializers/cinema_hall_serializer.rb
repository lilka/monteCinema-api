# frozen_string_literal: true

class CinemaHallSerializer
  include JSONAPI::Serializer
  attributes :name, :number_of_seats

  has_many :screenings
end
