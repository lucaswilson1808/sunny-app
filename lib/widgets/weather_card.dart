import 'package:flutter/material.dart';
import '../models/weather.dart';
import '../screens/location_overview_screen.dart';

class WeatherCard extends StatelessWidget {
  final Weather weather;
  final bool isCelsius;

  const WeatherCard({super.key, required this.weather, required this.isCelsius});

  @override
  Widget build(BuildContext context) {
    final temperature = isCelsius
        ? '${weather.temperature.toStringAsFixed(1)}°C'
        : '${((weather.temperature * 9 / 5) + 32).toStringAsFixed(1)}°F';

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LocationOverviewScreen(weather: weather),
          ),
        );
      },
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // City and Weather Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      weather.city,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${weather.region}, ${weather.country}',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Condition: ${weather.condition}',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),

              // Temperature Display
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  temperature,
                  style: const TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}