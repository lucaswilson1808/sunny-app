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
  });

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
    );
  }
}