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

ActiveRecord::Schema.define(:version => 20130713001913) do

  create_table "impressions", :force => true do |t|
    t.integer  "video_id"
    t.integer  "network_id"
    t.string   "ip_address",  :limit => 16
    t.string   "request_url", :limit => 200
    t.string   "referer",     :limit => 200
    t.string   "user_agent",  :limit => 200
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  add_index "impressions", ["created_at"], :name => "index_impressions_on_created_at"
  add_index "impressions", ["ip_address"], :name => "index_impressions_on_ip_address"
  add_index "impressions", ["network_id"], :name => "index_impressions_on_network_id"
  add_index "impressions", ["video_id"], :name => "index_impressions_on_video_id"

  create_table "networks", :force => true do |t|
    t.string   "name"
    t.string   "token",      :limit => 12
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  add_index "networks", ["token"], :name => "index_networks_on_token", :unique => true

  create_table "plays", :force => true do |t|
    t.integer  "impression_id"
    t.integer  "seconds_passed"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "state"
  end

  add_index "plays", ["impression_id"], :name => "index_plays_on_impression_id", :unique => true
  add_index "plays", ["state"], :name => "index_plays_on_state"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "name"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "videos", :force => true do |t|
    t.string   "token"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "user_id"
    t.float    "cpm"
  end

  add_index "videos", ["token"], :name => "index_videos_on_token", :unique => true
  add_index "videos", ["user_id"], :name => "video_user_id_index"

end
