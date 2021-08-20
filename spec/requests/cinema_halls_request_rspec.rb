# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'CinemaHalls', type: :request do
  describe 'GET /cinema_halls' do
    let(:cinema_hall) { create(:cinema_hall) }

    before do
      cinema_hall
    end

    subject(:get_cinema_halls) do
      get '/cinema_halls'
    end

    it 'returns http success' do
      get_cinema_halls
      expect(response).to have_http_status(200)
    end

    it 'returns not empty response' do
      get_cinema_halls
      json = JSON.parse(response.body)
      expect(json).to eq([{ 'id' => cinema_hall.id, 'name' => cinema_hall.name,
                            'number_of_seats' => cinema_hall.number_of_seats }])
    end
  end

  describe 'POST /cinema_halls' do
    context 'valid cinema_hall attributes' do
      let(:cinema_hall) { CinemaHall.new(name: 'Lalka', number_of_seats: 100) }
      subject(:create_cinema_hall) do
        post '/cinema_halls', params: { name: cinema_hall.name, number_of_seats: cinema_hall.number_of_seats }
      end

      it 'valid http status' do
        create_cinema_hall
        expect(response).to have_http_status(201)
      end

      it 'valid attributes' do
        create_cinema_hall
        json = JSON.parse(response.body)
        expect(json['name']).to eq(cinema_hall.name)
        expect(json['number_of_seats']).to eq(cinema_hall.number_of_seats)
      end

      it 'record created in database' do
        expect do
          create_cinema_hall
        end.to change {
                 CinemaHall.count
               }.by(1)
      end
    end

    context 'invalid cinema_hall attribute' do
      subject(:create_cinema_hall_with_invalid_attributes) do
        post '/cinema_halls', params:
         {
           number_of_seats: -10,
           name: ''
         }
      end

      it 'valid http status' do
        create_cinema_hall_with_invalid_attributes
        expect(response).to have_http_status(422)
      end
    end
  end

  describe 'PUT /cinema_halls' do
    let(:cinema_hall) { CinemaHall.create(name: 'Lalka', number_of_seats: 100) }

    before do
      cinema_hall
    end

    subject(:update_cinema_hall) do
      put "/cinema_halls/#{cinema_hall.id}", params: { number_of_seats: 150 }
    end

    context 'valid cinema_hall attributes' do
      it 'valid http status' do
        update_cinema_hall
        expect(response).to have_http_status(200)
      end
    end

    it 'valid attributes' do
      update_cinema_hall
      json = JSON.parse(response.body)
      expect(json).to eq({ 'id' => cinema_hall.id, 'name' => cinema_hall.name, 'number_of_seats' => '150' })
    end
  end

  describe 'DELETE cinema_halls' do
    let(:cinema_hall) { CinemaHall.create(name: 'Lalka', number_of_seats: 100) }

    before do
      cinema_hall
    end

    subject(:delete_cinema_hall) do
      delete "/cinema_halls/#{cinema_hall.id}"
    end

    it 'valid http status' do
      delete_cinema_hall
      expect(response).to have_http_status(204)
    end

    it 'record deleted form database' do
      expect { delete_cinema_hall }.to change {
        CinemaHall.count
      }.by(-1)
    end
  end
end
