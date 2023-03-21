class WeatherModel {
  final dynamic latitude;
  final dynamic longitude;
  final dynamic generationtimeMs;
  final dynamic utcOffsetSeconds;
  final String? timezone;
  final String? timezoneAbbreviation;
  final dynamic elevation;
  final CurrentWeather? currentWeather;

  WeatherModel({
    this.latitude,
    this.longitude,
    this.generationtimeMs,
    this.utcOffsetSeconds,
    this.timezone,
    this.timezoneAbbreviation,
    this.elevation,
    this.currentWeather,
  });

  WeatherModel.fromJson(Map<String, dynamic> json)
      : latitude = json['latitude'],
        longitude = json['longitude'],
        generationtimeMs = json['generationtime_ms'],
        utcOffsetSeconds = json['utc_offset_seconds'],
        timezone = json['timezone'],
        timezoneAbbreviation = json['timezone_abbreviation'],
        elevation = json['elevation'],
        currentWeather =
            (json['current_weather'] as Map<String, dynamic>?) != null
                ? CurrentWeather.fromJson(
                    json['current_weather'] as Map<String, dynamic>)
                : null;

  Map<String, dynamic> toJson() => {
        'latitude': latitude,
        'longitude': longitude,
        'generationtime_ms': generationtimeMs,
        'utc_offset_seconds': utcOffsetSeconds,
        'timezone': timezone,
        'timezone_abbreviation': timezoneAbbreviation,
        'elevation': elevation,
        'current_weather': currentWeather?.toJson()
      };
}

class CurrentWeather {
  final dynamic temperature;
  final dynamic windspeed;
  final dynamic winddirection;
  final dynamic weathercode;
  final dynamic time;

  CurrentWeather({
    this.temperature,
    this.windspeed,
    this.winddirection,
    this.weathercode,
    this.time,
  });

  CurrentWeather.fromJson(Map<String, dynamic> json)
      : temperature = json['temperature'],
        windspeed = json['windspeed'],
        winddirection = json['winddirection'],
        weathercode = json['weathercode'],
        time = json['time'];

  Map<String, dynamic> toJson() => {
        'temperature': temperature,
        'windspeed': windspeed,
        'winddirection': winddirection,
        'weathercode': weathercode,
        'time': time
      };
}
