# frozen_string_literal: true

class GenerateSeats
  InvalidNumberOfSeats = Class.new(StandardError)
  def initialize(cinema_hall_id, screening_id)
    @cinema_hall = CinemaHall.find(cinema_hall_id)
    @screening_id = screening_id
  end

  def call
    case @cinema_hall[:number_of_seats]
    when 200
      fill_seats(20, 10, @screening_id)
    when 100
      fill_seats(10, 10, @screening_id)
    when 50
      fill_seats(5, 10,  @screening_id)
    when 20
      fill_seats(5, 4, @screening_id)
    else
      raise InvalidNumberOfSeats, 'Error: invalid number of seats'
    end
  end

  private

  def fill_seats(rows, seats_in_row, screening_id)
    (1...rows + 1).each do |i|
      (1...seats_in_row + 1).each do |j|
        Seat.create(row: j, number: i, screening_id: screening_id)
      end
    end
  end
end
