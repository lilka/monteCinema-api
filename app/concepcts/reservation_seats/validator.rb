module ReservationSeats
  class Validator
    def initialize(seat_ids, screening_id, repository: ReservationSeats::Repository.new)
      @seat_ids = seat_ids
      @screening_id = screening_id
      @repository = repository
    end
    #potrzebuje znalezc  ilsoc miejsc jaka jest całkowiat dla danego screeningu, mogę to uzystac ze screeningu, albo przekazujac ille jest miejsc dla danesj cinema hall 
    def valid?
      seats_reserved = repository.reserved_seats(screening_id)
      all_seats = repository.all(screening_id)
      (seats_reserved & seat_ids).any? or (all_seats.count - seats_reserved.count > seat_ids.count)
    end

    private

    attr_reader :repository, :screening_id, :seat_ids
  end
end