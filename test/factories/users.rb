# frozen_string_literal: true
FactoryBot.define do
  factory :user do
    email { "test-#{SecureRandom.uuid}@test.com" }
    password { '12341234' }
  end
end
