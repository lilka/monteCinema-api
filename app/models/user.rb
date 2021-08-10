# frozen_string_literal: true

class User < ApplicationRecord
  belongs_to :role
  has_many :reservations, dependent: :destroy
  validates_associated :reservations
end
