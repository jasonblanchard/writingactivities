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

ActiveRecord::Schema.define(:version => 20130429161618) do

  create_table "activities", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "basic_reviews", :force => true do |t|
    t.integer  "user_id"
    t.integer  "submission_id"
    t.text     "works"
    t.text     "does_not_work"
    t.text     "main_idea"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "basic_reviews", ["submission_id"], :name => "index_peer_evaluations_on_submission_id"
  add_index "basic_reviews", ["user_id"], :name => "index_peer_evaluations_on_user_id"

  create_table "consumers", :force => true do |t|
    t.string   "name"
    t.string   "key"
    t.string   "secret"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "contexts", :force => true do |t|
    t.string   "context_label"
    t.string   "context_title"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "consumer_id"
  end

  create_table "memberships", :force => true do |t|
    t.integer  "user_id"
    t.integer  "context_id"
    t.string   "role"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "memberships", ["context_id"], :name => "index_memberships_on_context_id"
  add_index "memberships", ["user_id"], :name => "index_memberships_on_user_id"

  create_table "nonce_timestamps", :id => false, :force => true do |t|
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "nonce"
    t.string   "oauth_timestamp"
  end

  create_table "prompts", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.integer  "context_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "research_introduction_reviews", :force => true do |t|
    t.text     "so_what"
    t.text     "hook"
    t.text     "clarity"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "submission_id"
    t.integer  "user_id"
  end

  add_index "research_introduction_reviews", ["submission_id"], :name => "index_research_introduction_reviews_on_submission_id"
  add_index "research_introduction_reviews", ["user_id"], :name => "index_research_introduction_reviews_on_user_id"

  create_table "review_types", :force => true do |t|
    t.string   "review_type"
    t.integer  "prompt_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "review_types", ["prompt_id"], :name => "index_review_types_on_prompt_id"

  create_table "submissions", :force => true do |t|
    t.integer  "user_id"
    t.integer  "prompt_id"
    t.text     "body"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "submissions", ["prompt_id"], :name => "index_submissions_on_prompt_id"
  add_index "submissions", ["user_id"], :name => "index_submissions_on_user_id"

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
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
