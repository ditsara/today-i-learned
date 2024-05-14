# frozen_string_literal: true

class CreateUserContents < ActiveRecord::Migration[7.1]
  def change
    create_table :user_contents do |t|
      t.string :type
      t.references :owner, null: false, foreign_key: { to_table: :users }

      t.string :title, default: ''

      t.string :ancestry, collation: 'C', null: false
      t.index :ancestry

      t.datetime :edited_at
      t.timestamps
    end

    add_index :user_contents, %i[type owner_id]
    add_index :user_contents,
      %i[type created_at], order: { type: :asc, created_at: :desc }

    create_table :user_content_bookmarks do |t|
      t.references :user_content, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
