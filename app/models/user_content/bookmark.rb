class UserContent::Bookmark < ApplicationRecord
  belongs_to :user_content
  belongs_to :user

  validates :user_content_id, uniqueness: { scope: :user_id }
end
