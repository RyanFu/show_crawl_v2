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

ActiveRecord::Schema.define(:version => 20130627040041) do

  create_table "appprojects", :force => true do |t|
    t.string   "name"
    t.string   "iconurl"
    t.string   "pack"
    t.string   "clas"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "device_watch_infos", :force => true do |t|
    t.string   "registration_id", :null => false
    t.integer  "show_id"
    t.text     "watched_ep"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "device_watch_infos", ["registration_id"], :name => "index_device_watch_infos_on_registration_id"

  create_table "devices", :force => true do |t|
    t.string   "registration_id", :default => ""
    t.string   "device_id",       :default => ""
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  create_table "ep_v2s", :force => true do |t|
    t.string   "title"
    t.integer  "show_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "prelink"
  end

  add_index "ep_v2s", ["show_id"], :name => "index_ep_v2s_on_show_id"

  create_table "eps", :force => true do |t|
    t.string   "title"
    t.integer  "show_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "prelink"
  end

  add_index "eps", ["show_id"], :name => "index_eps_on_show_id"

  create_table "show_v2s", :force => true do |t|
    t.string   "name"
    t.text     "introduction"
    t.integer  "type_id"
    t.string   "poster_url"
    t.string   "hosts"
    t.string   "link"
    t.boolean  "is_shown",     :default => false
    t.integer  "views",        :default => 0
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  create_table "shows", :force => true do |t|
    t.string   "name"
    t.text     "introduction"
    t.integer  "type_id"
    t.string   "poster_url"
    t.string   "hosts"
    t.string   "link"
    t.boolean  "is_shown",     :default => false
    t.integer  "views",        :default => 0
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  add_index "shows", ["type_id"], :name => "index_shows_on_type_id"

  create_table "source_v2s", :force => true do |t|
    t.string   "link"
    t.integer  "ep_v2_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "source_v2s", ["ep_v2_id"], :name => "index_source_v2s_on_ep_v2_id"

  create_table "sources", :force => true do |t|
    t.string   "link"
    t.integer  "ep_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "sources", ["ep_id"], :name => "index_sources_on_ep_id"

  create_table "type_v2s", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
