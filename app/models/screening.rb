# frozen_string_literal: true

class Screening < ApplicationRecord
  belongs_to :cinema_hall
  belongs_to :movie
  has_many :seats
end
