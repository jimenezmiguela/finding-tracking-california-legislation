require 'faker'

FactoryBot.define do
    factory :bill do
        measure { Faker::Lorem.word }
        subject { Faker::Lorem.word }
        author { Faker::Lorem.word }
        status { Faker::Lorem.word }
        summary { Faker::Lorem.word }
        vote { Faker::Lorem.word }
        
        association :user
    end
end