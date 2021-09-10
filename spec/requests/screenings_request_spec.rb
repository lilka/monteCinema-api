# frozen_string_literal: true

require 'rails_helper'

RSpec.describe('Screenings', type: :request) do
  describe 'GET /screenings/:id' do
    let(:screening) { create(:screening) }

    subject(:show_screening) do
      get "/screenings/#{screening.id}"
    end
    it 'returns proper status' do
      show_screening
      expect(response).to have_http_status(200)
    end
  end
  describe 'GET /screenings' do
    let(:screening) { create(:screening) }

    before do
      screening
    end

    subject(:get_screenings) do
      get '/screenings'
    end

    it 'returns http success' do
      get_screenings
      expect(response).to have_http_status(200)
    end

    it 'returns not empty response' do
      get_screenings
      json = JSON.parse(response.body)
      expect(json).to eq(
        [
          {
            'id' => screening.id,
            'cinema_hall' => screening.cinema_hall.name,
            'movie_title' => screening.movie.title,
            'start_time' => '2021-08-18T00:00:00.000Z'
          }
        ]
      )
    end
  end

  describe 'POST /screenings' do
    context 'valid attributes' do
      let(:movie) { create(:movie) }
      let(:cinema_hall) { create(:cinema_hall) }
      let(:role) { create(:role, :employee_role) }
      let(:employee) { create(:user, role_id: role.id) }

      subject(:create_screening) do
        auth_params = fetch_auth_params_from_login(response)
        post '/screenings',
             params: { movie_id: movie.id, cinema_hall_id: cinema_hall.id, start_time: '2021-08-18T00:00:00.000Z' }, headers: auth_params
      end

      before do
        login(employee)
      end

      it 'valid http status' do
        create_screening
        expect(response).to have_http_status(201)
      end

      it 'valid attributes' do
        create_screening
        screening = Screening.last
        json = JSON.parse(response.body)
        expect(json).to eq(
          {
            'id' => screening.id,
            'cinema_hall' => screening.cinema_hall.name,
            'movie_title' => screening.movie.title,
            'start_time' => '2021-08-18T00:00:00.000Z'
          }
        )
      end

      it 'record created in database' do
        expect do
          create_screening
        end.to change {
          Screening.count
        }.by(1)
      end

      it 'seats created in database' do
        create_screening
        screening = Screening.last
        expect(screening.seats.count).to eq(100)
      end
    end

    context 'screening has invalid attributes' do
      let(:invalid_cinema_hall) { create(:cinema_hall, number_of_seats: 123) }
      let(:movie) { create(:movie) }
      let(:role) { create(:role, :employee_role) }
      let(:employee) { create(:user, role_id: role.id) }

      subject(:create_screening_with_invalid_attributes) do
        auth_params = fetch_auth_params_from_login(response)
        post '/screenings',
             params: {
               movie_id: movie.id,
               cinema_hall_id: invalid_cinema_hall.id,
               start_time: '2021-08-18T00:00:00.000Z'
             }, headers: auth_params
      end

      before do
        login(employee)
      end

      it 'invalid number of seats' do
        create_screening_with_invalid_attributes
        expect(JSON.parse(body)).to eq('errors' => 'Error: invalid number of seats')
      end
    end
  end
  describe 'PUT /screening' do
    let(:screening) { create(:screening) }
    let(:new_movie) { create(:movie) }
    let(:role) { create(:role, :employee_role) }
    let(:employee) { create(:user, role_id: role.id) }

    before do
      login(employee)
    end

    subject(:update_screening) do
      auth_params = fetch_auth_params_from_login(response)
      put "/screenings/#{screening.id}", params: { movie_id: new_movie.id }, headers: auth_params
    end

    subject(:update_screening_with_wrong_attrbutes) do
      auth_params = fetch_auth_params_from_login(response)
      put "/screenings/#{screening.id}", params: { movie_id: 0 }, headers: auth_params
    end

    it 'valid http status' do
      update_screening
      expect(response).to have_http_status(200)
    end

    it 'update screening with wrong attribute' do
      update_screening_with_wrong_attrbutes
      expect(response).to have_http_status(422)
    end
  end
end
