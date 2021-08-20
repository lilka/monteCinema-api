# frozen_string_literal: true

class Seat < ApplicationRecord
  has_and_belongs_to_many :reservations

end
