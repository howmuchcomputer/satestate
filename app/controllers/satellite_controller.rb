class SatelliteController < ApplicationController
  def health
    render plain: satellite.health
  end

  def stats
    render json: satellite.stats
  end

  def satellite
    @satellite ||= SATELLITE_API
  end
end
