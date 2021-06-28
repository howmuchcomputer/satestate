require 'rails_helper'

RSpec.describe "Satellites", type: :request do
  let(:satellite_api) do
    Satellite::API.new(
        logger: Rails.logger
    )
  end

  before :each do
    allow_any_instance_of(SatelliteController).to receive(:satellite).and_return(satellite_api)
    satellite_api.update
  end

  describe "GET /health" do
    before(:each) do
      get "/satellite/health"
    end

    it "returns http success", :vcr do
      expect(response).to have_http_status(:success)
    end

    it "returns the satellite's health", :vcr do
      expect(response.body).to eq satellite_api.health
    end
  end

  describe "GET /stats" do
    before(:each) do
      get "/satellite/stats"
    end

    it "returns http success", :vcr do
      expect(response).to have_http_status(:success)
    end

    it "returns the satellite's stats", :vcr do
      expect(response.body).to eq satellite_api.stats.to_json
    end
  end
end
