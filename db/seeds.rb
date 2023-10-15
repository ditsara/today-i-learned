# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

if Rails.env.development?
  20.times do
    user = User.create(
      name: "#{Faker::Name.first_name} #{Faker::Name.initials(number: 1)}",
      email: "test-#{SecureRandom.uuid}@test.com",
      password: "12341234"
    )

    (2..10).to_a.sample.times do
      t = SecureRandom.rand > 0.3 ? Faker::Company.bs.titleize : ""
      user.posts.new(
        title: t,
        body: Faker::Lorem.paragraphs.join("\n\n")
      ).save
    end
  end

  # Randomize all Post creation times
  UserContent::Post.all.each do |post|
    random_offset = (1..10).to_a.sample
    new_created_time = post.created_at + random_offset
    post.update_columns created_at: new_created_time
  end
end
