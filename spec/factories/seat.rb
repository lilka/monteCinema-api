# frozen_string_literal: true

FactoryBot.define do
  factory :seat do
    screening
    row { 10 }
    number { 10 }
  end
end
