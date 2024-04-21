class AuditEntry < ApplicationRecord
  belongs_to :auditable, polymorphic: true
  belongs_to :user

  # nobody should be able to change an audit AuditEntry once created (immutable)
  def readonly?
    !new_record?
  end
end
