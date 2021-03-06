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

ActiveRecord::Schema.define(version: 20160415164539) do

  create_table "document_keywords", force: :cascade do |t|
    t.integer  "document_id"
    t.integer  "keyword_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "documents", force: :cascade do |t|
    t.text     "text"
    t.integer  "group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "title"
  end

  create_table "groups", force: :cascade do |t|
    t.string   "name"
    t.string   "street_address"
    t.string   "city"
    t.string   "state"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "zip_code"
    t.string   "domain"
  end

  create_table "keyword_values", force: :cascade do |t|
    t.integer  "keyword_id"
    t.integer  "value_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "keywords", force: :cascade do |t|
    t.string   "word"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "language_codes", force: :cascade do |t|
    t.string   "name"
    t.string   "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "language_codes", ["name"], name: "index_language_codes_on_name"

  create_table "sentiments", force: :cascade do |t|
    t.float    "sentiment_score"
    t.integer  "polarity_score"
    t.integer  "record_id"
    t.string   "record_type"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "sentiment_percentage"
  end

  create_table "tweets", force: :cascade do |t|
    t.text     "text"
    t.integer  "favorite_count"
    t.integer  "retweets"
    t.date     "tweet_date"
    t.string   "user_verified"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "profile_image_url"
    t.string   "name"
    t.string   "location"
    t.integer  "twitter_search_id"
  end

  create_table "twitter_searches", force: :cascade do |t|
    t.string   "search_query"
    t.text     "description"
    t.integer  "group_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "result_type"
    t.integer  "tweet_count"
    t.string   "language_code"
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.integer  "group_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "password_digest"
  end

  create_table "values", force: :cascade do |t|
    t.float    "rating"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
