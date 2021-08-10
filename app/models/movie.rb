# frozen_string_literal: true

class Movie < ApplicationRecord
  has_many: screenings, dependent: :destroy
  validates_associated :screenings
  validates :duration_min , numerically: {greater_than: 1}
end
