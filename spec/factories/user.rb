# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { 'test@test.com' }
    password { 'password' }
    password_confirmation { 'password' }
    role
  end

  trait :employee do
    email { 'employee@test.com' }
    password { 'password' }
    password_confirmation { 'password' }
    employee_role
  end
end
