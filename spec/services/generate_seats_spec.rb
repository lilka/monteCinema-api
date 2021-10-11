#frozen_string_literal: true

require 'rails_helper'

RSpec.describe GenerateSeats do 
    subject(:generate_seats) { described_class.new(cinema_hall.id, screening.id).call }

    context "when number of seats are 200" do 
        let(:cinema_hall) { create(:cinema_hall, number_of_seats: 200) }
        let(:screening) { create(:screening) }
        it { expect{ generate_seats }.to change{Seat.count}.by(200) }
    end

    context "when number of seats are 100" do 
        let(:cinema_hall) { create(:cinema_hall, number_of_seats: 100) }
        let(:screening) { create(:screening) }
        it { expect{ generate_seats }.to change{Seat.count}.by(100) }
    end

    context "when number of seats are 50" do 
        let(:cinema_hall) { create(:cinema_hall, number_of_seats: 50) }
        let(:screening) { create(:screening) }
        it { expect{ generate_seats }.to change{Seat.count}.by(50) }
    end

    context "when number of seats are 20" do 
        let(:cinema_hall) { create(:cinema_hall, number_of_seats: 20) }
        let(:screening) { create(:screening) }
        it { expect{ generate_seats }.to change{Seat.count}.by(20) }
    end

    context "when there is invalid number of seats" do 
        let(:cinema_hall) { create(:cinema_hall, number_of_seats: 1000) }
        let(:screening) { create(:screening) }
        it { expect{ generate_seats }.to raise_error('Error: invalid number of seats' )}
    end
end