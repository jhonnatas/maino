FactoryBot.define do
  factory :post do
    title {Faker::Lorem.sentence(word_count: 3)} 
    content {Faker::Lorem.paragraphs(number: 2)}
    description {Faker::Lorem.sentence(word_count: 10)}

    user_id { create(:user).id }
    #category_id { create(:category, account_id:).id }

  end
end