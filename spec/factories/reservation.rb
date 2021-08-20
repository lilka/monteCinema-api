FactoryBot.define do
  factory :reservation do
    screening
    paid { false } 
    status { 'pending'}
    user { nil } 
  end
end