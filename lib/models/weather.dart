class Weather {
  final String city;
  final String region;
  final String country;
  final double temperature;
  final String condition;
  final String localTime;

  Weather({
    required this.city,
    required this.region,
    required this.country,
    required this.temperature,
    required this.condition,
    required this.localTime,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      city: json['location']['name'] ?? 'Unknown City',
      region: json['location']['region'] ?? 'Unknown Region',
      country: json['location']['country'] ?? 'Unknown Country',
      temperature: json['current']['temp_c']?.toDouble() ?? 0.0,
      condition: json['current']['condition']['text'] ?? 'Unknown Condition',
      localTime: json['location']['localtime'] ?? 'Unknown Time',
    );
  }
}