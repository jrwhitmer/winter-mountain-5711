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

ActiveRecord::Schema.define(version: 2021_06_15_153739) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "airlines", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "competitions", force: :cascade do |t|
    t.string "name"
    t.string "location"
    t.string "sport"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "doctors", force: :cascade do |t|
    t.string "name"
    t.string "specialty"
    t.string "university"
    t.bigint "hospital_id"
    t.index ["hospital_id"], name: "index_doctors_on_hospital_id"
  end

  create_table "flights", force: :cascade do |t|
    t.string "number"
    t.string "date"
    t.string "departure_city"
    t.string "arrival_city"
    t.bigint "airline_id"
    t.index ["airline_id"], name: "index_flights_on_airline_id"
  end

  create_table "hospitals", force: :cascade do |t|
    t.string "name"
  end

  create_table "passenger_flights", force: :cascade do |t|
    t.bigint "passenger_id"
    t.bigint "flight_id"
    t.index ["flight_id"], name: "index_passenger_flights_on_flight_id"
    t.index ["passenger_id"], name: "index_passenger_flights_on_passenger_id"
  end

  create_table "passengers", force: :cascade do |t|
    t.string "name"
    t.integer "age"
  end

  create_table "patient_doctors", force: :cascade do |t|
    t.bigint "doctors_id"
    t.bigint "patients_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["doctors_id"], name: "index_patient_doctors_on_doctors_id"
    t.index ["patients_id"], name: "index_patient_doctors_on_patients_id"
  end

  create_table "patients", force: :cascade do |t|
    t.string "name"
    t.integer "age"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "players", force: :cascade do |t|
    t.string "name"
    t.integer "age"
    t.bigint "team_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["team_id"], name: "index_players_on_team_id"
  end

  create_table "team_competitions", force: :cascade do |t|
    t.bigint "competition_id"
    t.bigint "team_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["competition_id"], name: "index_team_competitions_on_competition_id"
    t.index ["team_id"], name: "index_team_competitions_on_team_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "hometown"
    t.string "nickname"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "doctors", "hospitals"
  add_foreign_key "flights", "airlines"
  add_foreign_key "passenger_flights", "flights"
  add_foreign_key "passenger_flights", "passengers"
  add_foreign_key "patient_doctors", "doctors", column: "doctors_id"
  add_foreign_key "patient_doctors", "patients", column: "patients_id"
  add_foreign_key "players", "teams"
  add_foreign_key "team_competitions", "competitions"
  add_foreign_key "team_competitions", "teams"
end
