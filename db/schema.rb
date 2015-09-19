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

ActiveRecord::Schema.define(version: 20150919232050) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.integer  "resource_id"
    t.string   "full_street_address"
    t.string   "city"
    t.string   "state"
    t.string   "state_code"
    t.string   "postal_code"
    t.string   "country"
    t.string   "country_code"
    t.float    "longitude"
    t.float    "latitude"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "street1"
    t.string   "street2"
  end

  add_index "addresses", ["resource_id"], name: "index_addresses_on_resource_id", using: :btree

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "categories", ["name"], name: "index_categories_on_name", unique: true, using: :btree

  create_table "categories_resources", force: :cascade do |t|
    t.integer  "resource_id"
    t.integer  "category_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "categories_resources", ["category_id"], name: "index_categories_resources_on_category_id", using: :btree
  add_index "categories_resources", ["resource_id"], name: "index_categories_resources_on_resource_id", using: :btree

  create_table "phone_numbers", force: :cascade do |t|
    t.integer  "country_code"
    t.integer  "area_code"
    t.integer  "number"
    t.integer  "extension"
    t.text     "comment"
    t.integer  "resource_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "phone_numbers", ["resource_id"], name: "index_phone_numbers_on_resource_id", using: :btree

  create_table "resource_images", force: :cascade do |t|
    t.integer  "resource_id"
    t.string   "caption"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
  end

  add_index "resource_images", ["resource_id"], name: "index_resource_images_on_resource_id", using: :btree

  create_table "resources", force: :cascade do |t|
    t.string   "title"
    t.string   "email"
    t.text     "summary"
    t.text     "content"
    t.text     "website"
    t.integer  "page_id"
    t.integer  "revision_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "resources", ["page_id"], name: "index_resources_on_page_id", unique: true, using: :btree

  add_foreign_key "addresses", "resources"
  add_foreign_key "categories_resources", "categories"
  add_foreign_key "categories_resources", "resources"
  add_foreign_key "phone_numbers", "resources"
  add_foreign_key "resource_images", "resources"
end
