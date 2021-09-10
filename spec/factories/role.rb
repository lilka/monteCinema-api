# frozen_string_literal: true

FactoryBot.define do
  factory :role do
    role_name { 'client' }
  end
  trait :employee_role do
    role_name { 'employee' }
  end
end
