# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2023_10_15_072333) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "user_contents", force: :cascade do |t|
    t.string "type"
    t.integer "owner_id", null: false
    t.string "title", default: ""
    t.text "body", default: ""
    t.string "ancestry", null: false, collation: "C"
    t.datetime "edited_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ancestry"], name: "index_user_contents_on_ancestry"
    t.index ["type", "created_at"], name: "index_user_contents_on_type_and_created_at", order: { created_at: :desc }
    t.index ["type", "owner_id"], name: "index_user_contents_on_type_and_owner_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "crypted_password"
    t.string "salt"
    t.string "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_set_at"
    t.string "remember_me_token"
    t.datetime "remember_me_token_expires_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email"
    t.index ["remember_me_token"], name: "index_users_on_remember_me_token"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token"
  end

  add_foreign_key "user_contents", "users", column: "owner_id"
end
