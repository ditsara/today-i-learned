# frozen_string_literal: true

# Policy for UserContent::Reply
class UserContent::ReplyPolicy < ApplicationPolicy
  def update?
    return unless user

    record.owner_id == user.id || user.admin?
  end
end
