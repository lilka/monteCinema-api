# frozen_string_literal: true

class Screening < ApplicationRecord
  belongs_to :cinema_hall, :movie
end
