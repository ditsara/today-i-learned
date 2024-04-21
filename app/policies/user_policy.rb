# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  def update?
    record.user_id == user.id || user.admin?
  end
end
