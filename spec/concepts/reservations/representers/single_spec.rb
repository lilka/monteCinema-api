# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Reservations::Representers::Single do
  it 'represents single object' do
    reservation = create(:reservation)
    expect(described_class.new(reservation).call).to eq(
      paid: reservation.paid,
      screening: reservation.screening.movie.title,
      start_time: reservation.screening.start_time,
      cinema_hall: reservation.screening.cinema_hall.name,
      status: reservation.status
    )
  end
end
