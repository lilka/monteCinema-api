# frozen_string_literal: true

class User < ApplicationRecord

  # Include default devise modules.
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :omniauthable
  include DeviseTokenAuth::Concerns::User

 
  has_many :reservations
  
end
