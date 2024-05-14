# frozen_string_literal: true

class User < ApplicationRecord
  ROLES = %w[admin].freeze

  authenticates_with_sorcery!
  has_one_attached :avatar

  validates :email,
    presence: true,
    uniqueness: true,
    format: { with: /\A(.+)@(.+)\z/, message: 'is not a valid email format' }

  validates :password,
    length: { minimum: 8 },
    confirmation: true,
    presence: true,
    if: -> { new_record? || changes[:crypted_password] }

  validates :about, length: { maximum: 200 }

  has_many :user_contents, foreign_key: 'owner_id'
  has_many :posts, class_name: 'UserContent::Post', foreign_key: 'owner_id'
  has_many :bookmarks, class_name: 'UserContent::Bookmark'

  def bookmarked?(user_content)
    bookmarks.exists?(user_content_id: user_content.id)
  end

  # Check admin role. Note that user id=1 is a permanent admin, so this user
  # should be created as part of the initial deployment.
  def admin?
    id == 1 || roles.include?('admin')
  end

  def default_avatar
    DefaultAvatar.for(self)
  end
end
