# frozen_string_literal: true

require 'test_helper'

class UserContent::PostTest < ActiveSupport::TestCase
  include ActiveJob::TestHelper

  test 'is valid' do
    p = build :user_content_post
    assert_instance_of User, p.owner
    assert_nil p.parent
    assert p.valid?
  end

  test 'no owner (invalid)' do
    p = build :user_content_post, owner: nil
    assert_not p.valid?
  end

  test 'enqueues hashtag job on create' do
    p = build :user_content_post
    assert_enqueued_with(job: HashTagsUpdateJob) do
      p.save
    end
  end

  test 'enqueues hashtag job on update' do
    p = create :user_content_post
    assert_enqueued_with(job: HashTagsUpdateJob) do
      p.update(content: 'New stuff')
    end
  end
end
