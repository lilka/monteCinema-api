# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'CinemaHalls', type: :request do
  describe 'GET /cinema_halls' do
    it 'returns http success' do
      get '/cinema_halls'
      expect(response).to have_http_status(200)
    end
  end
end

RSpec.describe 'CinemaHalls', type: :request do
  describe 'POST /cinema_halls' do
    scenario 'valid cinema_hall attribute' do
      post '/cinema_halls', params: {
        cinema_hall: {
          number_of_seats: 50,
          name: 'Calineczka'
        }
      }

      expect(response).to have_http_status(201)

      json = JSON.parse(response.body).deep_symbolize_keys

      expect(json[:name]).to eq('Calineczka')
      expect(json[:number_of_seats]).to eq(50)

      expect(CinemaHall.count).to eq(1)
    end

    scenario 'invallid cinema_hall attribute' do
      post '/cinema_halls', params: {
        cinema_hall: {
          number_of_seats: -10,
          name: ''
        }
      }
      expect(response).to have_http_status(422)
    end
  end
end
