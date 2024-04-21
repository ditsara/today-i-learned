class CreateAuditEntries < ActiveRecord::Migration[7.1]
  def change
    create_table :audit_entries do |t|
      # polymorphic association
      t.integer :auditable_id
      t.string :auditable_type

      # user who made the change
      t.integer :user_id

      t.string :checksum

      t.timestamps
    end

    add_index :audit_entries, %i[auditable_id auditable_type]
    add_index :audit_entries, :checksum
  end
end
