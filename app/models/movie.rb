# frozen_string_literal: true

class Movie < ApplicationRecord
  has_many :screenings, dependent: :destroy
  validates :duration, numericality: { greater_than: 1 }
  attribute :duration, :interval
end
