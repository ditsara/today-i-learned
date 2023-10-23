class HashTag::Link < ApplicationRecord
  # def self.table_name_prefix
  #   "hash_tag_"
  # end

  belongs_to :hash_tag
  belongs_to :user_content
end
