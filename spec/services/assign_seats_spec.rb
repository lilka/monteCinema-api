#frozen_string_literal: true

require 'rails_helper'

RSpec.describe AssignSeats do 
    subject(:assign_seats) { described_class.new(reservation_id, params).call }
end