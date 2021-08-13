# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'CinemaHalls', type: :request do
  describe 'GET /cinema_halls' do
    let!(:cinema_hall) { CinemaHall.create(name: 'Lalka', number_of_seats: 100) }

    it 'returns http success' do
      get '/cinema_halls'
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST /cinema_halls' do
    context 'valid cinema_hall attributes' do
      let(:cinema_hall) { CinemaHall.new(name: 'Lalka', number_of_seats: 100) }

      it 'valid http status' do
        post '/cinema_halls', params: { name: cinema_hall.name, number_of_seats: cinema_hall.number_of_seats }
        expect(response).to have_http_status(201)
      end

      it 'valid attributes' do
        post '/cinema_halls', params: { name: cinema_hall.name, number_of_seats: cinema_hall.number_of_seats }
        json = JSON.parse(response.body)
        expect(json['name']).to eq(cinema_hall.name)
        expect(json['number_of_seats']).to eq(cinema_hall.number_of_seats)
      end

      it 'record created in database' do
        expect do
          post '/cinema_halls',
               params: { name: cinema_hall.name, number_of_seats: cinema_hall.number_of_seats }
        end.to change {
                 CinemaHall.count
               }.by(1)
      end
    end

    context 'invallid cinema_hall attribute' do
      it 'valid http status' do
        post '/cinema_halls', params:
         {
           number_of_seats: -10,
           name: ''
         }

        expect(response).to have_http_status(422)
      end
    end
  end

  describe 'PUT /cinema_halls' do
    let!(:cinema_hall) { CinemaHall.create(name: 'Lalka', number_of_seats: 100) }

    context 'valid cinema_hall attributes' do
      it 'valid http status' do
        put "/cinema_halls/#{cinema_hall.id}", params: { number_of_seats: 150 }

        expect(response).to have_http_status(200)
      end
    end

    it 'valid attributes' do
      put "/cinema_halls/#{cinema_hall.id}", params: { number_of_seats: 150 }

      json = JSON.parse(response.body)
      expect(json).to eq({ 'id' => cinema_hall.id, 'name' => cinema_hall.name, 'number_of_seats' => '150' })
    end
  end

  describe 'DELETE cinema_halls' do
    let!(:cinema_hall) { CinemaHall.create(name: 'Lalka', number_of_seats: 100) }
    it 'valid http status' do
      delete "/cinema_halls/#{cinema_hall.id}"
      expect(response).to have_http_status(204)
    end

    it 'record deleted form database' do
      expect { delete "/cinema_halls/#{cinema_hall.id}" }.to change {
        CinemaHall.count
      }.by(-1)
    end
  end
end
