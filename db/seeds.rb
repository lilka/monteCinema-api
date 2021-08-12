# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# movies = Movie.create([{ title: 'Star Wars', description: 'movie info #1', duration_min: 123 },
#                      { title: 'Lord of the Rings', description: 'movie info #2', duration_min: 143 }])

# cinema_halls = CinemaHall.create([{ number_of_seats: 100, name: 'Krolewna sniezka' },
#                                 {  number_of_seats: 200, name: 'Puchatek'}])

screenings = Screening.create([{ cinema_hall_id: 8, movie_id: 1, start_time: 17.00, date: Time.zone.now.to_s(:db) }])
