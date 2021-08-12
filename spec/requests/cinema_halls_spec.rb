require 'rails_helper'

RSpec.describe "CinemaHalls", type: :request do
  describe "GET /cinema_halls" do
    it "works! (now write some real specs)" do
      get cinema_halls_path
      expect(response).to have_http_status(200)
    end
  end
end
