# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CinemaHall, type: :model do
  describe 'test validation' do
    subject(:cinema_hall) { build(:cinema_hall) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:number_of_seats) }
  end
end
