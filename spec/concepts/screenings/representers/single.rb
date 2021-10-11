# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Screenings::Representers::Single do
  it 'represents single object' do
    screening = create(:screening)
    expect(described_class.new(screening).call).to eq(
      id: screening.id,
      movie_title: screening.movie.title,
      cinema_hall: screening.cinema_hall.name,
      start_time: screening.start_time
    )
  end
end
