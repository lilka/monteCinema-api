# frozen_string_literal: true

class Role < ApplicationRecord
  has_many :users, dependent: :destroy
  validates_associated :users
end
