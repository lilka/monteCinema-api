# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CinemaHalls::UseCases::Create do
  subject(:call_create) { described_class.new(params: params).call }

  context 'when valid params' do
    let(:params) { { number_of_seats: 100, name: 'Test', id: 1 } }

    it 'returns ??' do
      expect { call_create }.to change { CinemaHall.count }.by(1)
    end
  end
end
