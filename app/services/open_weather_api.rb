require 'opentelemetry'

class OpenWeatherApi
  attr_accessor :open_weather

  def initialize(params)
    @open_weather = OpenWeather::Client.new
    @city = params[:city]
    @tracer = OpenTelemetry.tracer_provider.tracer('weather_api', '0.0.1')
  end

  def call
    @tracer.in_span('GET /location/city/:city', kind: :server) do |span|
      @open_weather.current_weather(city: @city)
    end
  rescue Faraday::ResourceNotFound
    return { error: "No city found" }
  end
end