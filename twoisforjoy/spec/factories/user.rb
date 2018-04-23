require 'faker'

FactoryBot.define do
  factory :test_user, class: User do
    name { Faker::Name.first_name }
    email { Faker::Internet.unique.safe_email(name) }
    password { Faker::Internet.password }
    description { Faker::Lorem.paragraphs(6) }
    picture { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'support', 'users', 'pictures', '300.jpeg'), 'image/jpeg') }
  end
end
