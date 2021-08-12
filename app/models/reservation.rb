# frozen_string_literal: true

class Reservation < ApplicationRecord
  belongs_to :screening, :user
  has_many :tickets
  validates_associated :tickets
end
