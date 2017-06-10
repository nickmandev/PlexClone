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

ActiveRecord::Schema.define(version: 20170610123858) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: :cascade do |t|
    t.text "body"
    t.integer "vote_up", default: 0
    t.integer "vote_down", default: 0
    t.bigint "video_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.jsonb "user_info", default: {}
    t.index ["user_info"], name: "index_comments_on_user_info", using: :gin
    t.index ["video_id"], name: "index_comments_on_video_id"
  end

  create_table "comments_responses", force: :cascade do |t|
    t.text "body"
    t.integer "vote_up", default: 0
    t.integer "vote_down", default: 0
    t.jsonb "user_info", default: {}
    t.bigint "comment_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["comment_id"], name: "index_comments_responses_on_comment_id"
    t.index ["user_info"], name: "index_comments_responses_on_user_info", using: :gin
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
  end

  create_table "videos", force: :cascade do |t|
    t.text "video_data"
    t.bigint "user_id"
    t.string "url"
    t.string "thumbnail_url"
    t.string "user_info"
    t.datetime "created_at"
    t.integer "view_count"
    t.index ["user_id"], name: "index_videos_on_user_id"
  end

end
