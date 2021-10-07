# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CinemaHalls::Representers::Single do
  it 'represents single object' do
    cinema_hall = create(:cinema_hall)
    expect(described_class.new(cinema_hall).call).to eq(
      id: cinema_hall.id,
      name: cinema_hall.name,
      number_of_seats: cinema_hall.number_of_seats
    )
  end
end
