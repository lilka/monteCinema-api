# frozen_string_literal: true

class Reservation < ApplicationRecord
  belongs_to :screening
  belongs_to :user
  has_many :tickets, dependent: :destroy
  validates_associated :tickets
end
