# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Movies', type: :request do
  describe 'GET /movies' do
    let(:movie) { create(:movie) }
    let(:role) { create(:role, :employee_role) }
    let(:employee) { create(:user, role_id: role.id) }

    before do
      movie
    end

    subject(:get_movies) do
      auth_params = fetch_auth_params_from_login(response)
      get '/movies', headers: auth_params
    end
    context 'when authenticated' do
      before do
        login(employee)
      end

      it 'returns http success' do
        get_movies
        expect(response).to have_http_status(200)
      end

      it 'returns not empty response' do
        get_movies
        json = JSON.parse(response.body)
        expect(json).to eq([{ 'id' => movie.id, 'title' => movie.title,
                              'description' => movie.description, 'duration' => 'PT3M' }])
      end
    end
  end

  describe 'POST /movies' do
    context 'when authenticated' do
      let(:movie) { create(:movie) }
      let(:role) { create(:role, :employee_role) }
      let(:employee) { create(:user, role_id: role.id) }

      subject(:create_movie) do
        auth_params = fetch_auth_params_from_login(response)
        post '/movies', params: { title: movie.title, description: movie.description, duration: movie.duration },
                        headers: auth_params
      end

      context 'valid movie attributes' do
        let(:movie) { Movie.new(title: 'Pan Tadeusz', description: 'Lorem impsum', duration: 180) }

        before do
          login(employee)
        end

        it 'has valid http status' do
          create_movie
          expect(response).to have_http_status(201)
        end

        it 'has valid attributes' do
          create_movie
          json = JSON.parse(response.body)
          expect(json['title']).to eq(movie.title)
          expect(json['description']).to eq(movie.description)
          expect(json['duration']).to eq(movie.duration)
        end

        it 'record created in database' do
          expect do
            create_movie
          end.to change {
                   Movie.count
                 }.by(1)
        end
      end
    end

    context 'invalid movie attribute' do
      subject(:create_movie_with_invalid_attributes) do
        auth_params = fetch_auth_params_from_login(response)
        post '/movies', params: { titile: '', duration: -1 }, headers: auth_params
      end

      let(:role) { create(:role, :employee_role) }
      let(:employee) { create(:user, role_id: role.id) }

      before do
        login(employee)
      end

      it 'valid http status' do
        create_movie_with_invalid_attributes
        expect(response).to have_http_status(422)
      end
    end
  end
end

describe 'PUT /movies' do
  let(:role) { create(:role, :employee_role) }
  let(:employee) { create(:user, role_id: role.id) }
  let(:movie) { Movie.create(title: 'Lalka', description: 'description', duration: 123) }

  before do
    movie
  end

  subject(:update_movie) do
    auth_params = fetch_auth_params_from_login(response)
    put "/movies/#{movie.id}", params: { description: 'updated description', duration: 250 }, headers: auth_params
  end

  context 'valid movie attributes' do
    before do
      login(employee)
    end

    it 'valid http status' do
      update_movie
      expect(response).to have_http_status(200)
    end

    it 'valid attributes' do
      update_movie
      json = JSON.parse(response.body)
      expect(json).to eq({ 'id' => movie.id, 'title' => movie.title, 'description' => 'updated description',
                           'duration' => 'PT4M10S' })
    end
  end

  context 'update with invalid attributes' do
    subject(:update_movie_invalid_attributes) do
      auth_params = fetch_auth_params_from_login(response)
      put "/movies/#{movie.id}", params: { duration: -1 }, headers: auth_params
    end

    before do
      login(employee)
    end

    it 'invalid attributes' do
      update_movie_invalid_attributes

      expect(response).to have_http_status(422)
    end
  end

  context 'movie do not exists' do
    before do
      login(employee)
    end
    subject(:update_invalid_movie) do
      auth_params = fetch_auth_params_from_login(response)
      put '/movies/10', params: { title: 'Tabaluga' }, headers: auth_params
    end
    it 'valid error message ' do
      update_invalid_movie
      json = JSON.parse(response.body)
      expect(json).to eq({ 'error' => "Couldn't find Movie with 'id'=10" })
    end
  end
end
