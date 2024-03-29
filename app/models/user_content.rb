# frozen_string_literal: true

class UserContent < ApplicationRecord
  has_ancestry
  has_rich_text :content

  belongs_to :owner, class_name: 'User'
  has_many :hash_tag_links, class_name: 'HashTag::Link'
  has_many :hash_tags, through: :hash_tag_links

  after_save ->(uc) { HashTagsUpdateJob.perform_later uc.id }
end
