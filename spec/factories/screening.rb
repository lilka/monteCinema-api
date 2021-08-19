# frozen_string_literal: true

FactoryBot.define do
  factory :screening do
    cinema_hall
    movie
    start_time { DateTime.new(2021,8,18) }
  end
end