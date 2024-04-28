# frozen_string_literal: true

class HashTag < ApplicationRecord
  has_many :hash_tag_links, class_name: 'HashTag::Link'
  has_many :user_contents, through: :hash_tag_links

  def self.format(str)
    str.parameterize separator: '_'
  end

  def name=(str)
    self[:name] = HashTag.format(str)
  end

  def name_with_hash
    "##{name}"
  end
end
