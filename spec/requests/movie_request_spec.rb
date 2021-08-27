require 'rails_helper'

RSpec.describe 'Movies', type: :request do
  describe 'GET /movies' do
    let(:movie) { create(:movie) }
    let(:role) { create(:role) }
    let(:user) { create(:user) }

    before do
      movie
    end

    subject(:get_movies) do
      auth_params = get_auth_params_from_login_response_headers(response)
      get '/movies', headers: auth_params
    end
    context 'when authenticated' do
      before do
        login(user)
      end

      it 'returns http success' do
        get_movies
        expect(response).to have_http_status(200)
      end

      it 'returns not empty response' do
        get_movies
        json = JSON.parse(response.body)
        expect(json).to eq([{ 'id' => movie.id, 'title' => movie.title,
                              'description' => movie.description, 'duration' => movie.duration }])
      end
    end
  end

  describe 'POST /movies' do
    context 'when authenticated' do
      let(:movie) { create(:movie) }
      let(:role) { create(:role) }
      let(:user) { create(:user) }

      subject(:create_movie) do
        auth_params = get_auth_params_from_login_response_headers(response)
        post '/movies', params: { title: movie.title, description: movie.description, duration: movie.duration }, headers: auth_params
      end

      context 'valid movie attributes' do
        let(:movie) { Movie.new(title: "Pan Tadeusz", description: "Lorem impsum", duration: 180) }

        before do
          login(user)
        end

        it 'valid http status' do
          create_movie
          expect(response).to have_http_status(201)
        end

        it 'valid attributes' do
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
        auth_params = get_auth_params_from_login_response_headers(response)
        post '/movies', params: { titile: '', duration: -1 }, headers: auth_params
      end

      let(:role) { create(:role) }
      let(:user) { create(:user) }

      before do
        login(user)
      end

      it 'valid http status' do
        create_movie_with_invalid_attributes
        expect(response).to have_http_status(422)
      end
    end
  end
end

