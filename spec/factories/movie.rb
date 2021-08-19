# frozen_string_literal: true

FactoryBot.define do
  factory :movie do
    title { 'Pan Tadeusz' }
    description { 'Lorem impsum' }
    duration { 120 }
  end
end