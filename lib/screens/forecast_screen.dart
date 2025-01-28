import 'package:flutter/material.dart';
import '../models/weather.dart';

class ForecastScreen extends StatelessWidget {
  final Weather weather; // Pass the Weather object with forecast data

  const ForecastScreen({Key? key, required this.weather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("3-Day Forecast"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Section: City and Current Conditions
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
            // Cards for 3-Day Forecast
            Expanded(
              child: ListView.builder(
                itemCount: weather.forecast.length,
                itemBuilder: (context, index) {
                  final day = weather.forecast[index];
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
                        "${day.condition}\nHigh: ${day.highTemp}°C, Low: ${day.lowTemp}°C",
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}