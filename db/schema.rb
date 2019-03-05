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

ActiveRecord::Schema.define(version: 2019_03_03_133153) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_trgm"
  enable_extension "plpgsql"

  create_table "commands", force: :cascade do |t|
    t.string "name", null: false
    t.index ["name"], name: "trgm_command_name_index", opclass: :gin_trgm_ops, using: :gin
    t.index ["name"], name: "trgm_player_name_index", opclass: :gin_trgm_ops, using: :gin
  end

  create_table "games", force: :cascade do |t|
    t.boolean "ended", default: false, null: false
    t.datetime "created_at", null: false
    t.bigint "first_command_id", null: false
    t.bigint "second_command_id", null: false
    t.index ["first_command_id", "second_command_id"], name: "index_games_commands_unique", unique: true, where: "(ended = false)"
    t.index ["first_command_id"], name: "index_games_on_first_command_id"
    t.index ["second_command_id"], name: "index_games_on_second_command_id"
  end

# Could not dump table "performances" because of following StandardError
#   Unknown type 'per_type' for column 'per_type'

  create_table "players", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "command_id", null: false
    t.index ["command_id"], name: "index_players_on_command_id"
  end

  add_foreign_key "games", "commands", column: "first_command_id"
  add_foreign_key "games", "commands", column: "second_command_id"
  add_foreign_key "performances", "games"
  add_foreign_key "performances", "players"
  add_foreign_key "players", "commands"
end
