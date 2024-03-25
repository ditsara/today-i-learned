class CreateUserContents < ActiveRecord::Migration[7.1]
  def change
    create_table :user_contents do |t|
      t.string :type
      t.integer :owner_id, null: false

      t.string :title, default: ''

      t.string :ancestry, collation: 'C', null: false
      t.index :ancestry

      t.datetime :edited_at
      t.timestamps
    end

    add_foreign_key :user_contents, :users, column: :owner_id

    add_index :user_contents, %i[type owner_id]
    add_index :user_contents,
      %i[type created_at], order: { type: :asc, created_at: :desc }
  end
end
