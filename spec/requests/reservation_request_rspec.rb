 # frozen_string_literal: true

require 'rails_helper'

RSpec.describe('Reservations', type: :request) do
  describe 'POST/reservations' do 

  let(:screening) { create(:screening)}
  
   subject(:create_reservation) do 
     post '/reservations', params: { screening_id: screening.id, seats_amount: 2 }
   end


   it 'returns http status' do
     screening.send(:generate_seat, screening)
     create_reservation
     expect(response).to have_http_status(200)
   end
 end 
end
  