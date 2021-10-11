# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Seats::Representers::Single do
  it 'represents single object' do
    seat = create(:seat)
    expect(described_class.new(seat).call).to eq(
      id: seat.id,
      row: seat.row,
      number: seat.number
    )
  end
end
