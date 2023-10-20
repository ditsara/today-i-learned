FactoryBot.define do
  factory :user_content_post, class: 'UserContent::Post' do
    owner { association :user }
    title { SecureRandom.rand > 0.3 ? Faker::Company.bs.titleize : "" }
    body { Faker::Lorem.paragraphs.join("\n\n") }
  end
end
