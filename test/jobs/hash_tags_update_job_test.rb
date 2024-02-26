require 'test_helper'

class HashTagsUpdateJobTest < ActiveJob::TestCase
  test 'calls Hashtag::Scanner for each UserContent' do
    post = create :user_content_post
    reply = create :user_content_reply, parent: post
    HashTag::Scanner.expects(:update_links).with(post)
    HashTag::Scanner.expects(:update_links).with(reply)
    HashTagsUpdateJob.perform_now(post.id, reply.id)
  end
end
