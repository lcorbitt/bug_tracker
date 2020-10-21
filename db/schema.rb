# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_10_20_005832) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.text "message"
    t.string "commented_on_type"
    t.bigint "commented_on_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["commented_on_type", "commented_on_id"], name: "index_comments_on_commented_on_type_and_commented_on_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "action", null: false
    t.integer "recipient_id", null: false
    t.integer "notified_of_id", null: false
    t.string "notified_of_type", null: false
    t.datetime "read_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "projects", force: :cascade do |t|
    t.string "name", null: false
    t.text "description", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_projects_on_user_id"
  end

  create_table "ticket_assignees", force: :cascade do |t|
    t.bigint "ticket_id", null: false
    t.bigint "user_id", null: false
    t.index ["ticket_id"], name: "index_ticket_assignees_on_ticket_id"
    t.index ["user_id"], name: "index_ticket_assignees_on_user_id"
  end

  create_table "tickets", force: :cascade do |t|
    t.string "title", null: false
    t.bigint "user_id", null: false
    t.integer "status", default: 0, null: false
    t.bigint "project_id", null: false
    t.text "description", null: false
    t.integer "priority", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "ticket_type"
    t.index ["project_id"], name: "index_tickets_on_project_id"
    t.index ["user_id"], name: "index_tickets_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "username", null: false
    t.integer "role", default: 0
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "comments", "users"
  add_foreign_key "projects", "users"
  add_foreign_key "ticket_assignees", "tickets"
  add_foreign_key "ticket_assignees", "users"
  add_foreign_key "tickets", "projects"
  add_foreign_key "tickets", "users"
end
