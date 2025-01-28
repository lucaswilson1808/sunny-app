class Weather {
  final String city;
  final String region;
  final String country;
  final double temperature;
  final String condition;
  final String iconUrl;
  final String localTime;
  final double windSpeedKph;
  final double humidity;
  final double pressureMb;
  final double visibilityKm;
  final double uvIndex;
  final List<DailyForecast> forecast;

  Weather({
    required this.city,
    required this.region,
    required this.country,
    required this.temperature,
    required this.condition,
    required this.iconUrl,
    required this.localTime,
    required this.windSpeedKph,
    required this.humidity,
    required this.pressureMb,
    required this.visibilityKm,
    required this.uvIndex,
    required this.forecast,
  });

  // Factory constructor for current weather only
  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      city: json['location']['name'] ?? 'Unknown City',
      region: json['location']['region'] ?? 'Unknown Region',
      country: json['location']['country'] ?? 'Unknown Country',
      temperature: json['current']['temp_c']?.toDouble() ?? 0.0,
      condition: json['current']['condition']['text'] ?? 'Unknown Condition',
      iconUrl: json['current']['condition']['icon'] ?? '',
      localTime: json['location']['localtime'] ?? 'Unknown Time',
      windSpeedKph: json['current']['wind_kph']?.toDouble() ?? 0.0,
      humidity: json['current']['humidity']?.toDouble() ?? 0.0,
      pressureMb: json['current']['pressure_mb']?.toDouble() ?? 0.0,
      visibilityKm: json['current']['vis_km']?.toDouble() ?? 0.0,
      uvIndex: json['current']['uv']?.toDouble() ?? 0.0,
      forecast: [], // Empty forecast for current weather
    );
  }

  // Factory constructor for current weather and forecast
  factory Weather.fromJsonWithForecast(Map<String, dynamic> current, List<dynamic> forecastData) {
    return Weather(
      city: current['location']['name'] ?? 'Unknown City',
      region: current['location']['region'] ?? 'Unknown Region',
      country: current['location']['country'] ?? 'Unknown Country',
      temperature: current['current']['temp_c']?.toDouble() ?? 0.0,
      condition: current['current']['condition']['text'] ?? 'Unknown Condition',
      iconUrl: current['current']['condition']['icon'] ?? '',
      localTime: current['location']['localtime'] ?? 'Unknown Time',
      windSpeedKph: current['current']['wind_kph']?.toDouble() ?? 0.0,
      humidity: current['current']['humidity']?.toDouble() ?? 0.0,
      pressureMb: current['current']['pressure_mb']?.toDouble() ?? 0.0,
      visibilityKm: current['current']['vis_km']?.toDouble() ?? 0.0,
      uvIndex: current['current']['uv']?.toDouble() ?? 0.0,
      forecast: forecastData.map((day) => DailyForecast.fromJson(day)).toList(),
    );
  }
}

class DailyForecast {
  final String date;
  final String condition;
  final String iconUrl;
  final double highTemp;
  final double lowTemp;

  DailyForecast({
    required this.date,
    required this.condition,
    required this.iconUrl,
    required this.highTemp,
    required this.lowTemp,
  });

  factory DailyForecast.fromJson(Map<String, dynamic> json) {
    return DailyForecast(
      date: json['date'] ?? 'Unknown Date',
      condition: json['day']['condition']['text'] ?? 'Unknown Condition',
      iconUrl: json['day']['condition']['icon'] ?? '',
      highTemp: json['day']['maxtemp_c']?.toDouble() ?? 0.0,
      lowTemp: json['day']['mintemp_c']?.toDouble() ?? 0.0,
    );
  }
}