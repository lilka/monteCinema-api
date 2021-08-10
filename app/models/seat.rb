# frozen_string_literal: true

class Seat < ApplicationRecord
  belongs_to :cinema_hall
  has_one :ticket, dependent: :destroy
  validates_associated :ticket
end
