FactoryBot.define do
  factory :reservations do
    screening
    paid { false } 
    status { 'pending'}
    user
  end
end