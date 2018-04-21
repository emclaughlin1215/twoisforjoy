require 'faker'

FactoryBot.define do
  factory :test_user, class: User do
    name { Faker::Name.first_name }
    email { Faker::Internet.safe_email(name) }
    password { Faker::Internet.password }
  end
end