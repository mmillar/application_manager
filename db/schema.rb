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

ActiveRecord::Schema.define(:version => 20110729182721) do

  create_table "profiles", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "phone",                   :limit => 40
    t.string   "district",                :limit => 500
    t.text     "qualifications"
    t.text     "experience"
    t.string   "facebook_url"
    t.integer  "facebook_no_of_friends"
    t.string   "twitter_url"
    t.integer  "twitter_no_of_followers"
    t.text     "content_sample"
    t.text     "editorial_ideas"
    t.string   "key_issue_1"
    t.string   "key_issue_2"
    t.string   "key_issue_3"
    t.string   "media_formats"
    t.string   "equipment_access"
    t.string   "conflict_of_interest",    :limit => 1000
    t.string   "other_comments",          :limit => 1000
    t.boolean  "accepted_tos"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
