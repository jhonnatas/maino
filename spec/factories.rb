FactoryBot.define do
  factory :post do
    title { Faker::Lorem.word }
    description {Faker::Lorem.paragraphs(number: 2)}

    user_id { 1 }
  end
end