# frozen_string_literal: true

require 'rails_helper'

RSpec.describe('Auth', type: :request) do
  describe('POST /auth/sign_in') do
    let(:role) { create(:role) }
    let(:user) { create(:user) }

    before do
      user
    end

    subject(:sign_in) do
      post '/auth/sign_in'
    end

    it 'gives an authentication code if user exists and satisfies the password' do
      login(user)
      expect(response.has_header?('access-token')).to eq(true)
    end
  end
end
