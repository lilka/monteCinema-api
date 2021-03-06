# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'CinemaHalls', type: :request do
  describe 'GET /cinema_halls' do
    let(:cinema_hall) { create(:cinema_hall) }
    let(:role) { create(:role, :employee_role) }
    let(:employee) { create(:user, role_id: role.id) }
    let(:user) { create(:user) }

    before do
      cinema_hall
    end

    subject(:get_cinema_halls) do
      auth_params = fetch_auth_params_from_login(response)
      get '/cinema_halls', headers: auth_params
    end
    context 'when authenticated' do
      before do
        login(employee)
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
  end

  describe 'POST /cinema_halls' do
    context 'when authenticated' do
      let(:cinema_hall) { create(:cinema_hall) }
      let(:role) { create(:role, :employee_role) }
      let(:employee) { create(:user, role_id: role.id) }

      subject(:create_cinema_hall) do
        auth_params = fetch_auth_params_from_login(response)
        post '/cinema_halls', params: { name: cinema_hall.name, number_of_seats: cinema_hall.number_of_seats },
                              headers: auth_params
      end

      context 'valid cinema_hall attributes' do
        let(:cinema_hall) { CinemaHall.new(name: 'Lalka', number_of_seats: 100) }

        before do
          login(employee)
        end

        it 'has valid http status' do
          create_cinema_hall
          expect(response).to have_http_status(201)
        end

        it 'has valid attributes' do
          create_cinema_hall
          json = JSON.parse(response.body)
          expect(json['name']).to eq(cinema_hall.name)
          expect(json['number_of_seats']).to eq(cinema_hall.number_of_seats)
        end

        it 'creates record in database' do
          expect do
            create_cinema_hall
          end.to change {
                   CinemaHall.count
                 }.by(1)
        end
      end
    end

    context 'invalid cinema_hall attribute' do
      subject(:create_cinema_hall_with_invalid_attributes) do
        auth_params = fetch_auth_params_from_login(response)
        post '/cinema_halls', params: { number_of_seats: -10, name: '' }, headers: auth_params
      end

      let(:role) { create(:role, :employee_role) }
      let(:employee) { create(:user, role_id: role.id) }

      before do
        login(employee)
      end

      it 'has valid http status' do
        create_cinema_hall_with_invalid_attributes
        expect(response).to have_http_status(422)
      end
    end
  end
end

describe 'PUT /cinema_halls' do
  let(:cinema_hall) { create(:cinema_hall) }
  let(:role) { create(:role, :employee_role) }
  let(:employee) { create(:user, role_id: role.id) }
  let(:cinema_hall) { CinemaHall.create(name: 'Lalka', number_of_seats: 100) }

  before do
    cinema_hall
  end

  subject(:update_cinema_hall) do
    auth_params = fetch_auth_params_from_login(response)
    put "/cinema_halls/#{cinema_hall.id}", params: { number_of_seats: 150 }, headers: auth_params
  end

  context 'valid cinema_hall attributes' do
    before do
      login(employee)
    end

    it 'has valid http status' do
      update_cinema_hall
      expect(response).to have_http_status(200)
    end

    it 'has valid attributes' do
      update_cinema_hall
      json = JSON.parse(response.body)
      expect(json).to eq({ 'id' => cinema_hall.id, 'name' => cinema_hall.name, 'number_of_seats' => 150 })
    end
  end

  context 'ciname_hall do not exists' do
    before do
      login(employee)
    end
    subject(:update_invalid_cinema_hall) do
      auth_params = fetch_auth_params_from_login(response)
      put '/cinema_halls/10', params: { number_of_seats: 150 }, headers: auth_params
    end
    it 'has valid error message ' do
      update_invalid_cinema_hall
      json = JSON.parse(response.body)
      expect(json).to eq({ 'error' => "Couldn't find CinemaHall with 'id'=10" })
    end
  end
end
