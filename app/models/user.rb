class User < ApplicationRecord
  authenticates_with_sorcery!
  validates :email,
    presence: true,
    format: { with: /\A(.+)@(.+)\z/, message: "is not a valid email format" }
end
