# frozen_string_literal: true
FactoryBot.define do
  factory :hash_tag_link, class: 'HashTag::Link' do
    user_content { create :user_content_post }
    hash_tag { create :hash_tag }
  end
end
