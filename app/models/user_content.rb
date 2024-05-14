# frozen_string_literal: true

class UserContent < ApplicationRecord
  has_ancestry
  has_rich_text :content

  belongs_to :owner, class_name: 'User'
  has_many :hash_tag_links, class_name: 'HashTag::Link'
  has_many :hash_tags, through: :hash_tag_links
  has_many :bookmarks, class_name: 'UserContent::Bookmark'

  after_save ->(uc) { HashTag::UpdateJob.perform_later uc.id }

  scope :recents, -> { order(created_at: :desc) }

  has_many :audit_entries, as: :auditable
  # virtual attribute for the editor when updating content
  attribute :current_editor_id, :integer
  validate :current_editor_id_must_exist, on: :update
  after_update :create_audit_entry

  # virtual attribute for current user bookmark id
  # FIXME: this is really a decorator and should really be in a separate class
  attribute :current_user_bookmark
  def self.with_bookmarks_for(user)
    user_content_ids = pluck(:id)
    bookmarks = user.bookmarks.where(user_content_id: user_content_ids)
    all.tap do |ar|
      ar.each do |uc|
        uc.current_user_bookmark =
          bookmarks.find { _1.user_content_id == uc.id }
      end
    end
  end

  def with_bookmark_for(user)
    self.current_user_bookmark = user.bookmarks.find_by(user_content_id: id)
  end

  def current_editor_id_must_exist
    # skip if the content has not changed
    return if audit_entries.find_by(checksum: content_digest)

    errors.add(:current_editor_id, 'must be present when updating content') if current_editor_id.nil?

    return unless User.where(id: current_editor_id).empty?

    errors.add(:current_editor_id, 'must be a valid user')
  end

  def create_audit_entry
    AuditEntry.create!(
      auditable: self, user_id: current_editor_id, checksum: content_digest
    )
  end

  def content_digest
    audit_tag = "//#{audit_entries.count}-#{audit_entries.maximum(:updated_at)}"
    Digest::SHA256.hexdigest(content.to_s + audit_tag)
  end
end
