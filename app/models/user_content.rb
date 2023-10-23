class UserContent < ApplicationRecord
  has_ancestry

  belongs_to :owner, class_name: 'User'
  has_many :hash_tag_links, class_name: "HashTag::Link"
  has_many :hash_tags, through: :hash_tag_links
end
