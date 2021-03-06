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

ActiveRecord::Schema.define(:version => 20111024195801) do

  create_table "blog_trends", :force => true do |t|
    t.integer  "blog_id"
    t.integer  "trend_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "count"
  end

  create_table "blogs", :force => true do |t|
    t.integer  "user_id"
    t.integer  "category_id"
    t.string   "name"
    t.text     "description"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comment_posts", :force => true do |t|
    t.integer  "commenter"
    t.text     "body"
    t.integer  "post_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comment_posts", ["post_id"], :name => "index_comment_posts_on_post_id"

  create_table "entry_feed_trends", :force => true do |t|
    t.integer  "entry_feed_id"
    t.integer  "trend_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "entry_feeds", :force => true do |t|
    t.integer  "feed_id"
    t.string   "title"
    t.text     "summary"
    t.text     "content"
    t.string   "url"
    t.datetime "published_at"
    t.string   "guid"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "like"
    t.integer  "trend_count"
    t.string   "tags"
  end

  create_table "feed_categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "feeds", :force => true do |t|
    t.string   "name"
    t.string   "url"
    t.integer  "feed_category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "groups", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "post_contents", :force => true do |t|
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "post_trends", :force => true do |t|
    t.integer  "post_content_id"
    t.integer  "trend_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", :force => true do |t|
    t.integer  "user_id"
    t.integer  "category_id"
    t.integer  "post_content_id"
    t.integer  "like"
    t.boolean  "retrend"
    t.integer  "retrend_user_id"
    t.integer  "retrend_post_id"
    t.integer  "retrend_count"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "entry_feed_id"
  end

  create_table "trend_hops", :force => true do |t|
    t.integer  "trend_id"
    t.integer  "related_trend_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "count"
  end

  create_table "trends", :force => true do |t|
    t.string   "name"
    t.integer  "trend_category_id"
    t.integer  "like_count"
    t.integer  "trend_count"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_feeds", :force => true do |t|
    t.integer  "user_id"
    t.integer  "feed_id"
    t.integer  "feed_group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_following_trends", :force => true do |t|
    t.integer  "user_id"
    t.integer  "trend_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_followings", :force => true do |t|
    t.integer  "user_id"
    t.integer  "following_user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_friends", :force => true do |t|
    t.integer  "user_id"
    t.integer  "friend_id"
    t.integer  "group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_likes", :force => true do |t|
    t.integer  "user_id"
    t.integer  "source_id"
    t.string   "source_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_trends", :force => true do |t|
    t.integer  "user_id"
    t.integer  "trend_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "count"
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "domain"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "city"
    t.integer  "state_id"
    t.string   "sex"
    t.integer  "birth_day"
    t.integer  "birth_month"
    t.integer  "birth_year"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "role"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
