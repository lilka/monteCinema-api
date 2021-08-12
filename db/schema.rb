# frozen_string_literal: true

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

ActiveRecord::Schema.define(version: 20_210_812_084_515) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'cinema_halls', force: :cascade do |t|
    t.string 'name', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.integer 'number_of_seats'
  end

  create_table 'movies', force: :cascade do |t|
    t.string 'title'
    t.string 'description', null: false
    t.interval 'duration'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  create_table 'reservations', force: :cascade do |t|
    t.bigint 'screening_id', null: false
    t.boolean 'paid'
    t.string 'status'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.bigint 'user_id'
    t.index ['screening_id'], name: 'index_reservations_on_screening_id'
    t.index ['user_id'], name: 'index_reservations_on_user_id'
  end

  create_table 'roles', force: :cascade do |t|
    t.string 'role_name'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.bigint 'user_id', null: false
    t.index ['user_id'], name: 'index_roles_on_user_id'
  end

  create_table 'screenings', force: :cascade do |t|
    t.bigint 'cinema_hall_id'
    t.bigint 'movie_id'
    t.time 'start_time'
    t.date 'date'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['cinema_hall_id'], name: 'index_screenings_on_cinema_hall_id'
    t.index ['movie_id'], name: 'index_screenings_on_movie_id'
  end

  create_table 'seats', force: :cascade do |t|
    t.integer 'row'
    t.integer 'number'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.bigint 'screening_id', null: false
    t.index ['screening_id'], name: 'index_seats_on_screening_id'
  end

  create_table 'ticket_types', force: :cascade do |t|
    t.string 'name'
    t.decimal 'price'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  create_table 'tickets', force: :cascade do |t|
    t.bigint 'reservation_id', null: false
    t.bigint 'ticket_type_id', null: false
    t.bigint 'seat_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['reservation_id'], name: 'index_tickets_on_reservation_id'
    t.index ['seat_id'], name: 'index_tickets_on_seat_id'
    t.index ['ticket_type_id'], name: 'index_tickets_on_ticket_type_id'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['email'], name: 'index_users_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true
  end

  add_foreign_key 'reservations', 'screenings'
  add_foreign_key 'reservations', 'users'
  add_foreign_key 'roles', 'users'
  add_foreign_key 'screenings', 'cinema_halls'
  add_foreign_key 'screenings', 'movies'
  add_foreign_key 'seats', 'screenings'
  add_foreign_key 'tickets', 'reservations'
  add_foreign_key 'tickets', 'seats'
  add_foreign_key 'tickets', 'ticket_types'
end
