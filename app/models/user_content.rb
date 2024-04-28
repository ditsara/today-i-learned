# frozen_string_literal: true

class UserContent < ApplicationRecord
  has_ancestry
  has_rich_text :content

  belongs_to :owner, class_name: 'User'
  has_many :hash_tag_links, class_name: 'HashTag::Link'
  has_many :hash_tags, through: :hash_tag_links

  after_save ->(uc) { HashTag::UpdateJob.perform_later uc.id }

  scope :recents, -> { order(created_at: :desc) }


  has_many :audit_entries, as: :auditable
  # virtual attribute for the editor when updating content
  attribute :current_editor_id, :integer
  validate :current_editor_id_must_exist, on: :update
  after_update :create_audit_entry

  def current_editor_id_must_exist
    # skip if the content has not changed
    return if audit_entries.find_by(checksum: content_digest)

    if current_editor_id.nil?
      errors.add(:current_editor_id, 'must be present when updating content')
    end

    if User.where(id: current_editor_id).empty?
      errors.add(:current_editor_id, 'must be a valid user')
    end
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
