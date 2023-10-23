FactoryBot.define do
  factory :hash_tag do
    name { [Faker::Commerce.brand, Faker::Adjective.positive].sample }
  end
end
