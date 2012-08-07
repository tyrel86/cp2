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

ActiveRecord::Schema.define(:version => 20120806233109) do

  create_table "article_comments", :force => true do |t|
    t.integer  "article_id"
    t.integer  "user_id"
    t.text     "body"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "articles", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "user_id"
    t.integer  "volume_id"
    t.boolean  "editorial"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "assingments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "role_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "critiques", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.string   "photo_url"
    t.integer  "user_id"
    t.boolean  "critique_type"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "dispensaries", :force => true do |t|
    t.string   "name"
    t.string   "street_address"
    t.string   "city"
    t.string   "state"
    t.string   "zip_code"
    t.string   "phone_number"
    t.string   "latitude"
    t.string   "longitude"
    t.string   "api_key"
    t.integer  "dispensary_review"
    t.boolean  "sub_featured"
    t.boolean  "featured"
    t.boolean  "glass_sale"
    t.boolean  "whole_sale"
    t.boolean  "match_coupons"
    t.integer  "user_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "dispensary_comments", :force => true do |t|
    t.integer  "dispensary_id"
    t.integer  "user_id"
    t.text     "body"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "dispensary_reviews", :force => true do |t|
    t.integer  "dispensary_id"
    t.float    "bud_tenders"
    t.float    "selection"
    t.float    "atmosphere"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "grants", :force => true do |t|
    t.integer  "right_id"
    t.integer  "role_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "rights", :force => true do |t|
    t.string   "resource"
    t.string   "operation"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "searches", :force => true do |t|
    t.string  "search_term"
    t.integer "num_of_searches"
    t.integer "search_type"
  end

  create_table "strain_reviews", :force => true do |t|
    t.float    "couch_lock"
    t.float    "creativity"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "strain_id"
  end

  create_table "strain_wikis", :force => true do |t|
    t.integer  "strain_id"
    t.text     "flavors"
    t.text     "effect"
    t.text     "health_benefits"
    t.float    "sativa_indica"
    t.text     "ideal_growing_conditions"
    t.string   "origin"
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  create_table "strains", :force => true do |t|
    t.string   "name"
    t.integer  "strain_wiki_id"
    t.integer  "strain_review_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "user_dispensary_reviews", :force => true do |t|
    t.integer  "dispensary_id"
    t.integer  "user_id"
    t.integer  "bud_tenders"
    t.integer  "selection"
    t.integer  "atmosphere"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "user_profiles", :force => true do |t|
    t.integer  "user_id"
    t.string   "first_name"
    t.string   "last_name"
    t.date     "birth_day"
    t.boolean  "gender"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.string   "favorite_strains"
  end

  create_table "user_strain_reviews", :force => true do |t|
    t.integer  "strain_id"
    t.integer  "user_id"
    t.integer  "couch_lock"
    t.integer  "creativity"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "user_strain_wikis", :force => true do |t|
    t.integer  "strain_id"
    t.integer  "user_id"
    t.text     "flavors"
    t.text     "effect"
    t.text     "health_benefits"
    t.float    "sativa_indica"
    t.text     "ideal_growing_conditions"
    t.string   "origin"
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "user_name"
    t.string   "email"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "password_digest"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["user_name"], :name => "index_users_on_user_name", :unique => true

  create_table "volumes", :force => true do |t|
    t.boolean  "current"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "photo_url"
  end

end
