# frozen_string_literal: true

class Movie < ApplicationRecord
  has_many :screenings, dependent: :destroy
  validates :duration, numericality: { greater_than: 1 }
  validates :title, presence: true
  attribute :duration, :interval
end
