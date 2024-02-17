FactoryBot.define do
  factory :user_content_post, class: 'UserContent::Post' do
    owner { association :user }
    title { SecureRandom.rand > 0.3 ? Faker::Company.bs.titleize : "" }
    content { "<div>#{Faker::Lorem.paragraphs.join("<br><br>")}</div>" }
  end
end
