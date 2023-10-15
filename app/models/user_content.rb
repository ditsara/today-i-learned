class UserContent < ApplicationRecord
  has_ancestry

  belongs_to :owner, class_name: 'User'
end
