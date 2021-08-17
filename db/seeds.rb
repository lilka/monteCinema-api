# frozen_string_literal: true

require 'faker'


5.times do 
  Movie.create(title: Faker::Movie.title, duration: rand(75...300), description: Faker::Movie.quote)
end

CinemaHall.create(name: Faker::Fantasy::Tolkien.character, number_of_seats: 200)
CinemaHall.create(name: Faker::Fantasy::Tolkien.character, number_of_seats: 100)
CinemaHall.create(name: Faker::Fantasy::Tolkien.character, number_of_seats: 20)

9.times do 
    Screening.create(cinema_hall_id: CinemaHall.ids.sample, movie_id: Movie.ids.sample, start_time: 17, date: Faker::Date.in_date_period)
end
