require 'test_helper'

class HashTag::LinkTest < ActiveSupport::TestCase
  test 'creates new HashTag and HashTag::Link' do
    hash_tag_text = "##{Faker::Lorem.word}"
    post = create :user_content_post,
      content: "#{Faker::Lorem.paragraph} #{hash_tag_text}"

    assert_difference ['HashTag.count', 'HashTag::Link.count'], 1 do
      HashTag::Scanner.update_links post
    end

    new_hash_tag = HashTag.last
    new_hash_tag_link = HashTag::Link.last

    assert_equal hash_tag_text, new_hash_tag.name_with_hash
    assert_equal new_hash_tag, new_hash_tag_link.hash_tag
    assert_equal post, new_hash_tag_link.user_content
  end

  test 'links new Post to existing HashTag' do
    hash_tag = create :hash_tag, name: Faker::Lorem.word
    post = create :user_content_post,
      content: "#{Faker::Lorem.paragraph} #{hash_tag.name_with_hash}"

    assert_difference -> { HashTag.count } => 0,
      -> { HashTag::Link.count } => 1 do
        HashTag::Scanner.update_links post
      end

    new_hash_tag_link = HashTag::Link.last
    assert_equal hash_tag, new_hash_tag_link.hash_tag
    assert_equal post, new_hash_tag_link.user_content
  end

  test 'removes link from Post to HashTag' do
    post = create :user_content_post
    hash_tag = create :hash_tag, name: Faker::Lorem.word
    hash_tag_link = create(:hash_tag_link,
      user_content: post, hash_tag:)

    assert_difference 'HashTag::Link.count', -1 do
      HashTag::Scanner.update_links post
    end

    assert_equal 0, post.hash_tags.count
  end

  test 'no effect on valid linked HashTag' do
    hash_tag = create :hash_tag, name: Faker::Lorem.word
    post = create :user_content_post,
      content: "#{Faker::Lorem.paragraph} #{hash_tag.name_with_hash}"
    hash_tag_link = create(:hash_tag_link,
      user_content: post, hash_tag:)

    assert_no_difference 'HashTag::Link.count' do
      HashTag::Scanner.update_links post
    end

    assert_equal hash_tag, post.hash_tags.first
  end
end
