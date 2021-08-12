# frozen_string_literal: true

class Ticket < ApplicationRecord
  belongs_to :reservation
  belongs_to :type
  belongs_to :seat
end
