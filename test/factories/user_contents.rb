# frozen_string_literal: true
FactoryBot.define do
  factory :user_content do
    type { '' }
    title { 'MyString' }
    edited_at { '2023-10-15 14:23:33' }
    owner { nil }
  end
end
