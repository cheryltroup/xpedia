require 'factory_girl'

FactoryGirl.define do
  factory :wiki do
    title                Faker::Lorem.word
    body                 Faker::Lorem.sentences
    private              true
    user
  end
end
