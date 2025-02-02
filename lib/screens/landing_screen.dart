import 'package:flutter/material.dart';
import '../models/weather.dart';

class LandingScreen extends StatelessWidget {
  final Weather weather;
  final bool isCelsius;
  final VoidCallback onSearchPressed;

  const LandingScreen(
      {Key? key,
      required this.weather,
      required this.isCelsius,
      required this.onSearchPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Weather in ${weather.city}, ${weather.region}:",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 10),
          Text(
            "${weather.condition}",
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
          const SizedBox(height: 5),
          Text(
            "Temperature: ${isCelsius ? weather.temperature.toStringAsFixed(1) + "°C" : (weather.temperature * 9 / 5 + 32).toStringAsFixed(1) + "°F"}",
            style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 18),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(minimumSize: const Size(200, 50)),
            onPressed: onSearchPressed,
            child: const Text("Search for a Location"),
          ),
        ],
      ),
    );
  }
}
