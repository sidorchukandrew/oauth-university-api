# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_02_28_022129) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "guides", force: :cascade do |t|
    t.datetime "published_date"
    t.string "title"
    t.text "description"
    t.integer "read_time"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "series_id"
    t.boolean "published"
    t.index ["series_id"], name: "index_guides_on_series_id"
  end

  create_table "oauth_configs", force: :cascade do |t|
    t.string "scopes"
    t.string "base_url"
    t.bigint "section_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["section_id"], name: "index_oauth_configs_on_section_id"
  end

  create_table "sections", force: :cascade do |t|
    t.text "content"
    t.integer "ordinal"
    t.bigint "guide_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "section_type"
    t.index ["guide_id"], name: "index_sections_on_guide_id"
  end

  create_table "series", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "image_url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "published"
    t.datetime "published_date"
  end

  add_foreign_key "oauth_configs", "sections"
end
