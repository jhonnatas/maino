FactoryBot.define do
  factory :comment do
    usercomment {Faker::Internet.email} 
    body {Faker::Lorem.paragraphs(number: 2)}

    post_id { create(:post).id }
  end
end