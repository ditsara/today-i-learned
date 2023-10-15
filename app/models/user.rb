class User < ApplicationRecord
  authenticates_with_sorcery!
  validates :email,
    presence: true,
    uniqueness: true,
    format: { with: /\A(.+)@(.+)\z/, message: "is not a valid email format" }

  validates :password,
    length: { minimum: 8 },
    confirmation: true,
    presence: true,
    if: -> { new_record? || changes[:crypted_password] }
end
