# TableCheck Customer Reliability Take Home Project
## Project: Simple Weather API and Monitoring Integration

> [!NOTE]
> Apologies, I tried implementing Uptrace to monitor whether I've implemented the tracers correctly but to no avail.

### Installation
1. Clone the repository 
```
git@github.com:nicholodominguez/weather_api.git
```

2. Run `bundle install` on the project's main folder and install dependecies.

3. Register an account on OpenWeather and acquire an [API Keys](https://home.openweathermap.org/api_keys) 
```ruby
client = OpenWeather::Client.new(
  api_key: "1a2b3c4d5a6b7c8d9a8b7c6d5a4b3c2d1"
)
```
4. Create an account on Uptrace and follow the steps to acquire a [DSN](https://uptrace.dev/get/get-started.html#dsn)


5. Create `.env` file with the following values.

```ruby
OPEN_WEATHER_API_KEY=<open_weather_api_key> # Use your acquired API key on OpenWeather here
OTEL_EXPORTER=otlp 
OTEL_SERVICE_NAME=weather_api 
OTEL_EXPORTER_OTLP_ENDPOINT=http://localhost:4318
OTEL_RESOURCE_ATTRIBUTES=application=sparkapp rails server
UPTRACE_DSN=https://_j3PNPu09P-HZujhBB8cgA@api.uptrace.dev?grpc=4317

OTEL_EXPORTER_OTLP_HEADERS=<uptrace_dsn> # Use Uptrace DSN here

# Enable gzip compression.
OTEL_EXPORTER_OTLP_COMPRESSION=gzip

# Enable exponential histograms.
OTEL_EXPORTER_OTLP_METRICS_DEFAULT_HISTOGRAM_AGGREGATION=BASE2_EXPONENTIAL_BUCKET_HISTOGRAM

# Prefer delta temporality.
OTEL_EXPORTER_OTLP_METRICS_TEMPORALITY_PREFERENCE=DELTA
```

6. Run `rails server`

### Usage:
Path: `GET /location/city`

Required Parameters:
```ruby
  city: :string 
```

Expected Response:
```ruby
  {
    "id":1701668,
    "timezone":28800,
    "name":"Manila",
    "cod":200,
    "coord": { 
      "lon",
      "lat"
    },
    "weather": 
      [{ 
        "icon_uri",
        "icon"
        "id",
        "main": "Clouds",
        "description": "broken clouds"
      }],
      "base":"stations",
      "main": {
        "temp":299.25,
        "feels_like":299.25,
        "temp_min":298.7,
        "temp_max":299.32,
        "pressure":1013,
        "humidity":88
      },
      "visibility":10000,
      "wind": {
        "speed":1.54,
        "deg":30
      },
      "clouds":{
        "all":75
      },
      "rain":null,
      "snow":null,
      "dt":"2023-12-18T00:54:05.000Z",
      "sys":{
        "type":1,
        "id":8160,
        "country":"PH",
        "sunrise":"2023-12-17T22:14:26.000Z",
        "sunset":"2023-12-18T09:30:14.000Z"
      }
  }
```

JSON Format Response Field

* `coord`
  * `coord.lon` Longitude of the location
  * `coord.lat` Latitude of the location
* `weather` (more info [Weather condition codes](https://openweathermap.org/weather-conditions))
  * `weather.id` Weather condition id
  * `weather.main` Group of weather parameters (Rain, Snow, Clouds etc.)
  * `weather.description` Weather condition within the group. Please find more [here](https://openweathermap.org/current#list).
  * `weather.icon` Weather icon id
* `base` Internal parameter
* `main`
  * `main.temp` Temperature. Unit Default: Kelvin, Metric: Celsius, Imperial: Fahrenheit
  * `main.feels_like` Temperature. This temperature parameter accounts for the human perception of weather. Unit Default: Kelvin, Metric: Celsius, Imperial: Fahrenheit
  * `main.pressure` Atmospheric pressure on the sea level, hPa
  * `main.humidity` Humidity, %
  * `main.temp_min` Minimum temperature at the moment. This is minimal currently observed temperature (within large megalopolises and urban areas). Please find more info [here](https://openweathermap.org/current#min). Unit Default: Kelvin, Metric: Celsius, Imperial: Fahrenheit
  * `main.temp_max` Maximum temperature at the moment. This is maximal currently observed temperature (within large megalopolises and urban areas). Please find more info [here](https://openweathermap.org/current#min). Unit Default: Kelvin, Metric: Celsius, Imperial: Fahrenheit
  * `main.sea_level` Atmospheric pressure on the sea level, hPa
  * `main.grnd_level` Atmospheric pressure on the ground level, hPa
visibility Visibility, meter. The maximum value of the visibility is 10 km
* `wind`
  * `wind.speed` Wind speed. Unit Default: meter/sec, Metric: meter/sec, Imperial: miles/hour
  * `wind.deg` Wind direction, degrees (meteorological)
  * `wind.gust` Wind gust. Unit Default: meter/sec, Metric: meter/sec, Imperial: miles/hour
* `clouds`
  * `clouds.all` Cloudiness, %
* `rain`
  * `rain.1h` (where available) Rain volume for the last 1 hour, mm. Please note that only mm as units of measurement are available for this parameter
  * `rain.3h` (where available) Rain volume for the last 3 hours, mm. Please note that only mm as units of measurement are available for this parameter
* `snow`
  * `snow.1h`(where available) Snow volume for the last 1 hour, mm. Please note that only mm as units of measurement are available for this parameter
  * `snow.3h` (where available)Snow volume for the last 3 hours, mm. Please note that only mm as units of measurement are available for this parameter
* `dt` Time of data calculation, unix, UTC
* `sys`
  * `sys.type` Internal parameter
  * `sys.id` Internal parameter
  * `sys.message` Internal parameter
  * `sys.country` Country code (GB, JP etc.)
  * `sys.sunrise` Sunrise time, unix, UTC
  * `sys.sunset` Sunset time, unix, UTC
* `timezone` Shift in seconds from UTC
* `id` City ID. Please note that built-in geocoder functionality has been deprecated. Learn more [here](https://openweathermap.org/current#builtin)
* `name` City name. Please note that built-in geocoder functionality has been deprecated. Learn more [here](https://openweathermap.org/current#builtin)
* `cod` Internal parameter

### Suggestion for Improvement:

* **Multiple Cities/Location input** - There should be an endpoint where it accepts a collection of location or cities
* **Station input** - It should accept which station the user want to get it's data from
* **Hourly updates** - It should accept a range of time of forecasts
* **GraphQL integration** - This would help with the customization of response and it will futureproof the endpoints in case OpenWeather changes their API
