
FactoryBot.define do
  factory :user do
    email { 'test@test.com' }
    password { 'password' }
    password_confirmation { 'password' }
    role
  end
end
