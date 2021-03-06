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

ActiveRecord::Schema.define(version: 20150523142754) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "debtors", force: :cascade do |t|
    t.integer  "transaction_id"
    t.integer  "participant_id"
    t.integer  "amount"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "debtors", ["participant_id"], name: "index_debtors_on_participant_id", using: :btree
  add_index "debtors", ["transaction_id"], name: "index_debtors_on_transaction_id", using: :btree

  create_table "events", force: :cascade do |t|
    t.string   "title"
    t.integer  "creator_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "events", ["creator_id"], name: "index_events_on_creator_id", using: :btree

  create_table "families", force: :cascade do |t|
    t.string   "name"
    t.integer  "creator_id"
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "families", ["event_id"], name: "index_families_on_event_id", using: :btree

  create_table "participants", force: :cascade do |t|
    t.string   "default_name"
    t.integer  "user_id"
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "family_id"
  end

  add_index "participants", ["event_id"], name: "index_participants_on_event_id", using: :btree
  add_index "participants", ["family_id"], name: "index_participants_on_family_id", using: :btree
  add_index "participants", ["user_id"], name: "index_participants_on_user_id", using: :btree

  create_table "payers", force: :cascade do |t|
    t.integer  "transaction_id"
    t.integer  "participant_id"
    t.integer  "amount"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "payers", ["participant_id"], name: "index_payers_on_participant_id", using: :btree
  add_index "payers", ["transaction_id"], name: "index_payers_on_transaction_id", using: :btree

  create_table "transactions", force: :cascade do |t|
    t.string   "description"
    t.integer  "amount"
    t.integer  "event_id"
    t.integer  "creator_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "transactions", ["creator_id"], name: "index_transactions_on_creator_id", using: :btree
  add_index "transactions", ["event_id"], name: "index_transactions_on_event_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: ""
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["invitation_token"], name: "index_users_on_invitation_token", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
