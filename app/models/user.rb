# frozen_string_literal: true

class User < ApplicationRecord

  # Include default devise modules.
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :omniauthable
  include DeviseTokenAuth::Concerns::User
  has_many :reservations

  before_create :set_default_role

  private
   def set_default_role
    self.role_id ||= Role.find_by(role_name: 'client').id
   end
  
end
