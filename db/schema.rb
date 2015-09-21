# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140821101153) do

  create_table "answers", force: true do |t|
    t.integer  "question_id"
    t.integer  "status",      default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "report_id"
    t.text     "notes"
    t.string   "file"
  end

  create_table "categories", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "customers", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "bill_of_laden"
    t.string   "name"
    t.string   "phone"
    t.string   "loading_address"
    t.string   "destination_address"
    t.string   "tag_lot_number"
    t.string   "tag_lot_color"
    t.string   "agent_name"
    t.date     "date_of_pickup"
    t.string   "charges"
    t.integer  "user_id"
    t.integer  "creator_id"
    t.boolean  "close",               default: false
    t.datetime "close_date"
  end

  create_table "customers_users", force: true do |t|
    t.integer  "user_id"
    t.integer  "customer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "incidents", force: true do |t|
    t.string   "report_type"
    t.string   "your_name"
    t.string   "job_title"
    t.date     "injury_date"
    t.time     "injury_time"
    t.string   "witnesses"
    t.string   "location"
    t.string   "circumstances"
    t.string   "event_discription"
    t.string   "injuries_type"
    t.boolean  "ppe_used"
    t.boolean  "medical_assistance_provided"
    t.integer  "project_id"
    t.integer  "downloaded"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "file"
  end

  create_table "invitations", force: true do |t|
    t.string   "email"
    t.string   "name"
    t.string   "role"
    t.integer  "user_id"
    t.string   "auth_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "items", force: true do |t|
    t.string   "item_number"
    t.string   "description_at_origin"
    t.string   "driver"
    t.string   "warehouse"
    t.string   "warehouse_cross"
    t.string   "shipper"
    t.string   "desr_symbole"
    t.string   "exception_symbol"
    t.string   "location_symbol"
    t.string   "file1"
    t.string   "file2"
    t.string   "exception"
    t.integer  "customer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "cn",                    default: false
    t.string   "article"
  end

  create_table "projects", force: true do |t|
    t.string   "name"
    t.string   "address"
    t.string   "contact_info"
    t.integer  "user_id"
    t.integer  "creator_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projects_users", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "project_id"
  end

  create_table "questions", force: true do |t|
    t.text     "body"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reports", force: true do |t|
    t.integer  "project_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.date     "submit"
  end

  create_table "tokens", force: true do |t|
    t.string   "api"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "authentication_token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "role"
    t.integer  "client_id"
    t.string   "company"
    t.string   "phone"
    t.string   "address"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
