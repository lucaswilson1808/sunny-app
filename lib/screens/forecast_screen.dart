import 'package:flutter/material.dart';
import '../models/weather.dart';

class ForecastScreen extends StatelessWidget {
  final Weather weather;
  final bool isCelsius;

  const ForecastScreen({Key? key, required this.weather, required this.isCelsius}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${weather.city}, ${weather.region}",
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "Current Conditions: ${weather.condition}",
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: weather.forecast.length,
              itemBuilder: (context, index) {
                final day = weather.forecast[index];
                final highTemp = isCelsius ? day.highTemp : (day.highTemp * 9 / 5) + 32;
                final lowTemp = isCelsius ? day.lowTemp : (day.lowTemp * 9 / 5) + 32;
                final unit = isCelsius ? "°C" : "°F";

                return Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: ListTile(
                    leading: Image.network(
                      "http:${day.iconUrl}",
                      width: 50,
                      height: 50,
                    ),
                    title: Text(day.date),
                    subtitle: Text(
                      "${day.condition}\nHigh: ${highTemp.toStringAsFixed(1)}$unit, Low: ${lowTemp.toStringAsFixed(1)}$unit",
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}