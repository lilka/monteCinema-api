# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Movies::Representers::Single do
  it 'represents single object' do
    movie = create(:movie)
    expect(described_class.new(movie).call).to eq(
      id: movie.id,
      title: movie.title,
      description: movie.description,
      duration: movie.duration
    )
  end
end
