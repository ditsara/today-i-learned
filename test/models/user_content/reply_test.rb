# frozen_string_literal: true

require 'test_helper'

class UserContent::ReplyTest < ActiveSupport::TestCase
  include ActiveJob::TestHelper

  test 'is valid' do
    p = create :user_content_post
    r = build :user_content_reply, parent: p
    assert_instance_of User, r.owner
    assert r.valid?
  end

  test 'no owner (invalid)' do
    p = create :user_content_post
    r = build :user_content_reply, parent: p, owner: nil
    assert_not r.valid?
  end

  test 'enqueues hashtag job on create' do
    p = create :user_content_post
    r = build :user_content_reply, parent: p
    assert_enqueued_with(job: HashTag::UpdateJob) do
      r.save
    end
  end

  test 'enqueues hashtag job on update' do
    r = create :user_content_reply
    assert_enqueued_with(job: HashTag::UpdateJob) do
      r.update(content: 'New stuff', current_editor_id: r.owner.id)
    end
  end

  test 'audit entry created on update' do
    r = create :user_content_reply
    assert_difference 'AuditEntry.count' do
      r.update(content: 'New stuff', current_editor_id: r.owner.id)
    end

    audit_entry = r.audit_entries.first
    assert_equal r, audit_entry.auditable
    assert_equal r.owner.id, audit_entry.user_id
  end
end
