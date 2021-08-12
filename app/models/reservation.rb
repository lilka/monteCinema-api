# frozen_string_literal: true

class Reservation < ApplicationRecord
  belongs_to :screening
  belongs_to :user, optional: true
  has_many :tickets
  validates_associated :tickets
end
