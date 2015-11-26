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

ActiveRecord::Schema.define(version: 20151007113321) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "championships", force: true do |t|
    t.integer  "competition_id"
    t.integer  "team_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position",         default: 1
    t.integer  "points",           default: 0
    t.integer  "played",           default: 0
    t.integer  "won",              default: 0
    t.integer  "drawn",            default: 0
    t.integer  "lost",             default: 0
    t.integer  "goals_for",        default: 0
    t.integer  "goals_against",    default: 0
    t.integer  "goals_difference", default: 0
  end

  create_table "competitions", force: true do |t|
    t.string   "name"
    t.string   "kind"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "place"
    t.integer  "number_teams"
    t.boolean  "teams_added",   default: false
    t.boolean  "post",          default: false
    t.boolean  "started",       default: false
    t.integer  "number_rounds"
  end

  create_table "fixtures", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "round_id"
    t.integer  "team1_id"
    t.integer  "team2_id"
    t.integer  "result_team1"
    t.integer  "result_team2"
    t.date     "date"
    t.time     "hour"
    t.boolean  "done",         default: false
    t.string   "local"
  end

  add_index "fixtures", ["round_id"], name: "index_fixtures_on_round_id", using: :btree

  create_table "friendly_id_slugs", force: true do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "pred_fixtures", force: true do |t|
    t.integer  "pred_round_id"
    t.integer  "pred_result_team1"
    t.integer  "pred_result_team2"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "fixture_id"
    t.boolean  "out_of_date_time",  default: false
    t.integer  "points",            default: 0
    t.boolean  "filled",            default: false
  end

  add_index "pred_fixtures", ["fixture_id"], name: "index_pred_fixtures_on_fixture_id", using: :btree
  add_index "pred_fixtures", ["pred_round_id"], name: "index_pred_fixtures_on_pred_round_id", using: :btree

  create_table "pred_rounds", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "prediction_id"
    t.integer  "round_id"
  end

  add_index "pred_rounds", ["prediction_id"], name: "index_pred_rounds_on_prediction_id", using: :btree
  add_index "pred_rounds", ["round_id"], name: "index_pred_rounds_on_round_id", using: :btree

  create_table "predictions", force: true do |t|
    t.integer  "competition_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "points",         default: 0
    t.integer  "position",       default: 1
  end

  create_table "rounds", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "competition_id"
    t.integer  "number_round"
    t.boolean  "done",           default: false
  end

  add_index "rounds", ["competition_id"], name: "index_rounds_on_competition_id", using: :btree

  create_table "teams", force: true do |t|
    t.string   "name"
    t.string   "country"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "flag"
    t.string   "short_name", limit: 3
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "nickname"
    t.string   "email"
    t.date     "birth"
    t.boolean  "gender"
    t.string   "city"
    t.string   "phone"
    t.string   "mobile"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.datetime "confirmed_at"
    t.string   "confirmation_token"
    t.string   "slug"
    t.string   "picture"
    t.boolean  "admin",              default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["slug"], name: "index_users_on_slug", unique: true, using: :btree

end
