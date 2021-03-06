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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20111203164101) do

  create_table "articles", :force => true do |t|
    t.string   "title"
    t.text     "article"
    t.text     "keyword"
    t.boolean  "current",    :default => false
    t.boolean  "public",     :default => false
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bulletins", :force => true do |t|
    t.string   "title"
    t.string   "bulletin"
    t.boolean  "current"
    t.boolean  "public"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", :force => true do |t|
    t.text     "body"
    t.string   "status"
    t.integer  "ticket_id"
    t.string   "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "locations", :force => true do |t|
    t.string   "name"
    t.string   "address"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "locations", ["name"], :name => "index_locations_on_name"

  create_table "tickets", :force => true do |t|
    t.string   "title"
    t.text     "issue"
    t.string   "ticket_type"
    t.string   "priority"
    t.string   "urgency"
    t.string   "impact"
    t.string   "status"
    t.string   "resolution"
    t.text     "resolution_explanation"
    t.integer  "location_id"
    t.integer  "contact"
    t.integer  "assigned_to"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "last_name"
    t.string   "first_name"
    t.string   "middle_name"
    t.string   "employee_number"
    t.string   "email"
    t.string   "work_phone"
    t.string   "cell_phone"
    t.boolean  "worker",             :default => false
    t.boolean  "admin",              :default => false
    t.string   "encrypted_password"
    t.string   "salt"
    t.integer  "location_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["employee_number"], :name => "index_users_on_employee_number", :unique => true
  add_index "users", ["last_name"], :name => "index_users_on_last_name"

end
