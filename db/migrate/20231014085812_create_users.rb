class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :crypted_password
      t.string :salt
      t.string :reset_password_token
      t.datetime :reset_password_token_expires_at
      t.datetime :reset_password_email_set_at
      t.string :remember_me_token
      t.datetime :remember_me_token_expires_at
      t.timestamps
    end

    add_index :users, :remember_me_token
    add_index :users, :reset_password_token
    add_index :users, :email
  end
end
