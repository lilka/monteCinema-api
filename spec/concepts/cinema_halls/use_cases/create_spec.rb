# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CinemaHalls::UseCases::Create do
  subject(:call_create) { described_class.new(params: params).call }

  context 'when valid params' do
    let(:params) { { number_of_seats: 100, name: 'Test', id: 1 } }

    it { expect { call_create }.to change { CinemaHall.count }.by(1) }
    it { expect(call_create).to be_kind_of(CinemaHall) }
    it "assigns proper attributes to created CinemaHall" do 
       call_create
       cinema_hall = CinemaHall.find_by(name: params[:name])
       expect(cinema_hall).to have_attributes(params)
    end
  end

  context "when invalid params" do
    let(:params) { { number_of_seats: -100, name: "Test", id: 1} }    
  end 
end
