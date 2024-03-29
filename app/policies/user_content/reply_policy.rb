# frozen_string_literal: true

class UserContent::ReplyPolicy < ApplicationPolicy
  def update?
    record.owner_id == user.id
  end
end
