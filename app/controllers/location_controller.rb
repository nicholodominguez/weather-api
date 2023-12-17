class LocationController < ApplicationController
  def city
    @client = OpenWeatherApi.new(params)

    render json: @client.call
  end
end
