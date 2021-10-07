# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Movies::UseCases::Create do
  subject(:call_create) { described_class.new(params: params).call }

  context 'when valid params' do
    let(:params) { { title: "Test", description: 'Test description', duration: 100 } }

    it { expect { call_create }.to change { Movie.count }.by(1) }
    it { expect(call_create).to be_kind_of(Movie) }
  end

  context "when invalid params" do
    let(:params) { { title: nil, description: 'Test description', duration: -100 } }
  end 
end
