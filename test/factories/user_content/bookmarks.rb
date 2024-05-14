FactoryBot.define do
  factory :user_content_bookmark, class: 'UserContent::Bookmark' do
    user_content { association :user_content_post }
    user { association :user }
  end
end
