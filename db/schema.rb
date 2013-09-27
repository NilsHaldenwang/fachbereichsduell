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

ActiveRecord::Schema.define(:version => 20130927111426) do

  create_table "answerers", :force => true do |t|
    t.string   "ip"
    t.integer  "question_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "answerers", ["question_id"], :name => "index_answerers_on_question_id"

  create_table "estimation_answers", :force => true do |t|
    t.float    "value"
    t.integer  "question_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "game_states", :force => true do |t|
    t.string   "state"
    t.integer  "team_1_points"
    t.integer  "team_2_points"
    t.integer  "team_1_x"
    t.integer  "team_2_x"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "question_number"
  end

  create_table "questions", :force => true do |t|
    t.integer  "number"
    t.string   "text"
    t.string   "question_type"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.float    "answer_luecke"
    t.float    "answer_rollinger"
    t.integer  "rounding_factor"
    t.integer  "min"
    t.integer  "max"
  end

  add_index "questions", ["number"], :name => "index_questions_on_number", :unique => true

  create_table "text_answers", :force => true do |t|
    t.string   "content"
    t.string   "state",            :default => "hidden"
    t.integer  "count",            :default => 0
    t.integer  "question_id"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.integer  "answered_by_team"
  end

end
