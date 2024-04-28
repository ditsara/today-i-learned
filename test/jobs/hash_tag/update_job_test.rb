# frozen_string_literal: true

require 'test_helper'

class HashTag::UpdateJobTest < ActiveJob::TestCase
  test 'calls internal class for each UserContent' do
    post = create :user_content_post
    reply = create :user_content_reply, parent: post
    HashTag::UpdateJob::Updater.any_instance.expects(:update_links).with(post)
    HashTag::UpdateJob::Updater.any_instance.expects(:update_links).with(reply)
    HashTag::UpdateJob.perform_now(post.id, reply.id)
  end
end
