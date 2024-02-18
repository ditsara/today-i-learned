class UserContent::PostPolicy < ApplicationPolicy
  def update?
    record.owner_id == user.id
  end
end
