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

ActiveRecord::Schema.define(version: 2019_05_19_142116) do

  create_table "bed_details", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "images", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "path"
    t.string "imageable_type"
    t.bigint "imageable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["imageable_type", "imageable_id"], name: "index_images_on_imageable_type_and_imageable_id"
  end

  create_table "location_types", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "locations", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "location_type_id"
    t.string "name"
    t.string "location"
    t.string "national"
    t.string "zip_code"
    t.text "description"
    t.boolean "status", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.json "pictures"
    t.decimal "total_rate", precision: 2, scale: 1
    t.index ["location_type_id"], name: "index_locations_on_location_type_id"
    t.index ["name"], name: "index_locations_on_name", unique: true
    t.index ["national"], name: "index_locations_on_national"
    t.index ["user_id"], name: "index_locations_on_user_id"
  end

  create_table "reservation_details", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "description"
    t.datetime "start_date"
    t.datetime "end_date"
    t.bigint "reservation_id"
    t.bigint "room_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["end_date"], name: "index_reservation_details_on_end_date"
    t.index ["reservation_id"], name: "index_reservation_details_on_reservation_id"
    t.index ["room_id"], name: "index_reservation_details_on_room_id"
    t.index ["start_date"], name: "index_reservation_details_on_start_date"
  end

  create_table "reservations", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.decimal "total_bill", precision: 12, scale: 3
    t.integer "status", limit: 1, default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_reservations_on_user_id"
  end

  create_table "reviews", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "location_id"
    t.string "comment"
    t.integer "rate", limit: 1, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["location_id"], name: "index_reviews_on_location_id"
    t.index ["rate"], name: "index_reviews_on_rate"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "rooms", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.integer "occupancy_limit", limit: 2
    t.integer "living_room", limit: 1
    t.integer "bed_room", limit: 1
    t.integer "bath_room", limit: 1
    t.integer "number_of_bed", limit: 1
    t.integer "quantity", limit: 1, null: false
    t.decimal "price", precision: 12, scale: 3
    t.bigint "bed_detail_id"
    t.bigint "location_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.json "pictures"
    t.boolean "status", default: true
    t.index ["bed_detail_id"], name: "index_rooms_on_bed_detail_id"
    t.index ["location_id"], name: "index_rooms_on_location_id"
  end

  create_table "rooms_services", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "room_id"
    t.bigint "service_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["room_id"], name: "index_rooms_services_on_room_id"
    t.index ["service_id"], name: "index_rooms_services_on_service_id"
  end

  create_table "services", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "email", null: false
    t.string "password_digest"
    t.string "remember_digest"
    t.boolean "admin", default: false
    t.string "activation_digest"
    t.boolean "activated", default: false
    t.datetime "activated_at"
    t.string "reset_digest"
    t.datetime "reset_sent_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "locations", "location_types"
  add_foreign_key "locations", "users"
  add_foreign_key "reservation_details", "reservations"
  add_foreign_key "reservation_details", "rooms"
  add_foreign_key "reservations", "users"
  add_foreign_key "reviews", "locations"
  add_foreign_key "reviews", "users"
  add_foreign_key "rooms", "bed_details"
  add_foreign_key "rooms", "locations"
  add_foreign_key "rooms_services", "rooms"
  add_foreign_key "rooms_services", "services"
end
