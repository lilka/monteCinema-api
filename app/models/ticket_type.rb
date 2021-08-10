# frozen_string_literal: true

class TicketType < ApplicationRecord
  has_many :tickets, dependent: :destroy
  validates_associated :tickets
end
