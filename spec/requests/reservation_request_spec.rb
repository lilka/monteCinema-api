# frozen_string_literal: true

require 'rails_helper'

RSpec.describe('Reservations', type: :request) do
  describe 'POST/reservations' do
    let(:screening) { create(:screening) }
    let(:role) { create(:role) }
    let(:user) { create(:user) }

    before do
      GenerateSeats.new(screening.cinema_hall_id, screening.id).call
    end
    let(:seat_ids) { screening.seats.take(2).map(&:id) }

    context 'when authenticated' do
      before do
        login(user)
      end
      context 'reservation is created' do
        subject(:create_reservation) do
          auth_params = get_auth_params_from_login_response_headers(response)
          post '/reservations', params: { screening_id: screening.id, seat_ids: seat_ids, user_id: user.id },
                                headers: auth_params
        end

        it 'returns http status' do
          create_reservation
          expect(response).to have_http_status(200)
        end

        it 'record created in database' do
          expect do
            create_reservation
          end.to change {
            Reservation.count
          }.by(1)
        end

        it 'seats assign to reservation' do
          create_reservation
          reservation = Reservation.last
          seats_reservations = ReservationsSeats.where(reservation_id: reservation.id)
          expect(seats_reservations.count).to eq(2)
        end
      end

      context 'reservation falis' do
        subject(:create_reservation_with_wrong_params) do
          auth_params = get_auth_params_from_login_response_headers(response)
          post '/reservations',
               params: { screening_id: screening.id, seat_ids: screening.seats.ids, user_id: user.id }, headers: auth_params
        end

        it 'returns error message' do
          create_reservation_with_wrong_params
          json = JSON.parse(response.body)
          expect(json).to eq({ 'message' => 'No more pleaces for this screening' })
        end
      end
    end
  end

  describe 'GET reservations/' do
    let(:screening) { create(:screening) }
    let(:reservation) { create(:reservation) }
    let(:role) { create(:role) }
    let(:user) { create(:user, email: 'new@email.com') }

    before do
      seat_id = screening.seats.first.to_a
      GenerateSeats.new(screening.cinema_hall_id, screening.id).call
      AssignSeats.new(reservation.id, seat_id, screening.id).call
      login(user)
    end

    subject(:get_reservations) do
      auth_params = get_auth_params_from_login_response_headers(response)
      get '/reservations', headers: auth_params
    end

    it 'valid http status' do
      get_reservations
      expect(response).to have_http_status(200)
    end
  end
end
