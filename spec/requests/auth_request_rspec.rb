require 'rails_helper'
include ActionController::RespondWith


RSpec.describe('Auth', type: :request) do
  describe ('POST /auth/sign_in') do 
    let(:role) { create(:role) }
    let(:user) { create(:user) }

    before do 
      user
    end

    subject(:sign_in) do 
      post '/auth/sign_in'
    end

    it 'gives you an authentication code if you are an existing user and you satisfy the password' do
      login(user)
      expect(response.has_header?('access-token')).to eq(true)
    end

  end
end 