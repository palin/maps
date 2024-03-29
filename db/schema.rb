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

ActiveRecord::Schema.define(version: 20131212220037) do

  create_table "abuses", force: true do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "name"
    t.integer  "report_id"
  end

  create_table "categories", force: true do |t|
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.string   "unique_id",  limit: 3
  end

  create_table "opinions", force: true do |t|
    t.string   "title"
    t.string   "description"
    t.integer  "positives",   default: 0
    t.integer  "negatives",   default: 0
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "report_id"
  end

  create_table "reports", force: true do |t|
    t.string   "title"
    t.string   "description"
    t.string   "photo"
    t.integer  "positives",                           default: 0
    t.integer  "negatives",                           default: 0
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.integer  "category_id"
    t.decimal  "latitude",    precision: 8, scale: 6
    t.decimal  "longitude",   precision: 8, scale: 6
    t.text     "photo_data"
  end

  create_table "users", force: true do |t|
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.string   "name"
    t.string   "login"
    t.string   "password"
    t.string   "password_confirmation"
    t.string   "crypted_password"
    t.string   "email"
    t.date     "date_of_birth"
    t.string   "salt"
    t.string   "persistence_token"
  end

end
