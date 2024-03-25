# frozen_string_literal: true

FactoryBot.define do
  factory :user_content_reply, class: 'UserContent::Reply' do
    parent { association :user_content_post }
    owner { association :user }
  end
end
