class OpenWeatherApi
  attr_accessor :open_weather

  def initialize(params)
    @open_weather = OpenWeather::Client.new
    @city = params[:city]
  end

  def call
    @open_weather.current_weather(city: @city)
  rescue Faraday::ResourceNotFound
    return { error: "No city found" }
  end
end