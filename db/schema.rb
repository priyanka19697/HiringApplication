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

ActiveRecord::Schema.define(version: 2020_02_09_145410) do

  create_table "applications", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "mobile"
    t.integer "experience"
    t.string "resume"
    t.integer "status_id", null: false
    t.integer "job_id", null: false
    t.datetime "joining_date"
    t.text "rejection_reason"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "user_id"
    t.text "interviewee_feedback"
    t.index ["job_id"], name: "index_applications_on_job_id"
    t.index ["status_id"], name: "index_applications_on_status_id"
    t.index ["user_id"], name: "index_applications_on_user_id"
  end

  create_table "interviews", force: :cascade do |t|
    t.integer "application_id", null: false
    t.integer "user_id", null: false
    t.datetime "scheduled_date"
    t.integer "status_id", null: false
    t.text "interview_feedback"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["application_id"], name: "index_interviews_on_application_id"
    t.index ["status_id"], name: "index_interviews_on_status_id"
    t.index ["user_id"], name: "index_interviews_on_user_id"
  end

  create_table "jobs", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "statuses", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.integer "role_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["role_id"], name: "index_users_on_role_id"
  end

  add_foreign_key "applications", "jobs"
  add_foreign_key "applications", "statuses"
  add_foreign_key "interviews", "applications"
  add_foreign_key "interviews", "statuses"
  add_foreign_key "interviews", "users"
  add_foreign_key "users", "roles"
end
