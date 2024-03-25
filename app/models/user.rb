class User < ApplicationRecord
  authenticates_with_sorcery!
  validates :email,
    presence: true,
    uniqueness: true,
    format: { with: /\A(.+)@(.+)\z/, message: 'is not a valid email format' }

  validates :password,
    length: { minimum: 8 },
    confirmation: true,
    presence: true,
    if: -> { new_record? || changes[:crypted_password] }

  has_many :user_contents, foreign_key: 'owner_id'
  has_many :posts, class_name: 'UserContent::Post', foreign_key: 'owner_id'
end
