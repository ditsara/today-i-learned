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
  # Create some common HashTags
  hash_tags = 10.times.map do
    HashTag.create name: Faker::Lorem.word
  end

  # Use this random generator later
  get_random_hash_tag_texts = lambda do |max = 2|
    how_many_hash_tags = (0..max).to_a.sample
    hash_tags.sample(how_many_hash_tags).map(&:name_with_hash)
  end

  # convert text array to Trix content
  paras_to_trix = lambda do |paras|
    s = paras.join('<br/><br/>')
    %(<div class="trix-content"><div>#{s}</div></div>)
  end

  # Make users with Posts
  20.times do
    user = User.create(
      name: "#{Faker::Name.first_name} #{Faker::Name.initials(number: 1)}",
      email: "test-#{SecureRandom.uuid}@test.com",
      password: 'abc123D$'
    )

    (2..10).to_a.sample.times do
      t = SecureRandom.rand > 0.3 ? Faker::Company.bs.titleize : ''

      body_content = Faker::Lorem.paragraphs + get_random_hash_tag_texts.call

      post = user.posts.new(
        title: t,
        body: body_content.join("\n\n") # TODO: remove this entire col
      )
      post.save
      ActionText::RichText.create! record_type: 'UserContent',
                                   record_id: post.id,
                                   name: 'content',
                                   body: paras_to_trix.call(body_content)
    end
  end

  # Make replies to each post
  UserContent::Post.all.each do |post|
    (0..10).to_a.sample.times do
      body_content = Faker::Lorem.paragraphs + get_random_hash_tag_texts.call(1)
      reply = post.replies.new parent: post,
                               owner: User.order('RANDOM()').limit(1).first,
                               body: body_content.join("\n\n")
      reply.save
      ActionText::RichText.create! record_type: 'UserContent',
                                   record_id: reply.id,
                                   name: 'content',
                                   body: paras_to_trix.call(body_content)
    end
  end

  # Randomize all Post and Reply creation times
  UserContent::Post.all.each do |post|
    random_offset_1 = (0..7).to_a.sample.days
    random_offset_2 = (0..60).to_a.sample.minutes
    t = post.created_at - random_offset_1 - random_offset_2
    post.update_columns created_at: t, updated_at: t

    post.replies.each do |reply|
      random_offset_3 = (0..360).to_a.sample.minutes
      t = post.created_at + random_offset_3
      reply.update_columns created_at: t, updated_at: t
    end
  end

  UserContent.all.each { HashTag::Scanner.update_links _1 }
end
