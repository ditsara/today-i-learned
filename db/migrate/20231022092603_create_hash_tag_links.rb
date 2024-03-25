# frozen_string_literal: true

class CreateHashTagLinks < ActiveRecord::Migration[7.1]
  def change
    create_table :hash_tags do |t|
      t.string :name

      t.timestamps
    end

    create_table :hash_tag_links do |t|
      t.integer :user_content_id
      t.integer :hash_tag_id

      t.timestamps
    end

    add_foreign_key :hash_tag_links, :user_contents, column: :user_content_id
    add_foreign_key :hash_tag_links, :hash_tags, column: :hash_tag_id

    add_index :hash_tag_links, :hash_tag_id
    add_index :hash_tag_links, :user_content_id
  end
end
