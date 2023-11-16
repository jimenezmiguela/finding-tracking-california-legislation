require 'faker'

FactoryBot.define do
    factory :user do |f|
        f.first_name { Faker::Name.name }
        f.last_name { Faker::Lorem.word }
        f.email { Faker::Internet.email }
        f.password { Faker::Internet.password }
    end
end