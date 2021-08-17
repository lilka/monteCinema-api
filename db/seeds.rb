# frozen_string_literal: true

require 'faker'

def generate_seat(screening)
  cinema_hall = CinemaHall.find(screening[:cinema_hall_id])
  number_of_seats = cinema_hall[:number_of_seats]
  id = screening.id
  case number_of_seats
  when 200
    fill_seats(20, 10, id)
  when 100
    fill_seats(10, 10, id)
  when 50
    fill_seats(5, 10, id)
  when 20
    fill_seats(5, 4, id)
  else
    'Error: invalid number of seats'
  end
end

def fill_seats(rows, seats_in_row, screening_id)
  (1...rows + 1).each do |i|
    (1...seats_in_row + 1).each do |j|
      Seat.create(row: j, number: i, screening_id: screening_id)
    end
  end
end

5.times do
  Movie.create(title: Faker::Movie.title, duration: rand(75...300), description: Faker::Movie.quote)
end

CinemaHall.create(name: Faker::Fantasy::Tolkien.character, number_of_seats: 200)
CinemaHall.create(name: Faker::Fantasy::Tolkien.character, number_of_seats: 100)
CinemaHall.create(name: Faker::Fantasy::Tolkien.character, number_of_seats: 50)
CinemaHall.create(name: Faker::Fantasy::Tolkien.character, number_of_seats: 20)

9.times do
  screening = Screening.create(cinema_hall_id: CinemaHall.ids.sample, movie_id: Movie.ids.sample, start_time: 17,
                               date: Faker::Date.in_date_period)
  generate_seat(screening)
end
