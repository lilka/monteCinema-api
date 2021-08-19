class AssignSeats 
  def initialize(reservation_id, seats_amount, screening_id)
    @reservation = Reservation.find(reservation_id)
    @seats_amount = seats_amount
    @screening_id = screening_id
  end

  def call 
    @seats_amount.times do
      seat = AvaliableSeats.new(@screening_id).call.first
      @reservation.seats.push(seat)
    end  
  end
end