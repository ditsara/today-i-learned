# frozen_string_literal: true

class UserContent::PostPolicy < ApplicationPolicy
  def update?
    record.owner_id == user.id || user.admin?
  end
end
