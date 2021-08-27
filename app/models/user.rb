# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules.
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :omniauthable
  include DeviseTokenAuth::Concerns::User
  has_many :reservations
  belongs_to :role, ooptional: true

  before_create :set_default_role

  private

  def set_default_role
    self.role ||= Role.find_by(role_name: 'client')
  end
end
