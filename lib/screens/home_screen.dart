import 'package:flutter/material.dart';
import '../services/weather_api.dart';
import '../models/weather.dart';
import '../widgets/weather_card.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback onToggleTheme;

  const HomeScreen({Key? key, required this.onToggleTheme}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Weather? weather;
  final TextEditingController cityController = TextEditingController();
  bool isCelsius = true; // Track temperature unit

  Future<void> fetchWeather() async {
    final city = cityController.text;
    if (city.isNotEmpty) {
      final fetchedWeather = await WeatherApi.fetchWeather(city);
      setState(() {
        weather = fetchedWeather;
      });

      if (weather == null) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Error'),
            content: const Text('Could not fetch weather for the entered city.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    }
  }

  void toggleTemperatureUnit() {
    setState(() {
      isCelsius = !isCelsius;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sunny'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'Toggle Theme') {
                widget.onToggleTheme();
              } else if (value == 'Toggle Unit') {
                toggleTemperatureUnit();
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'Toggle Theme',
                child: Text('Toggle Dark/Light Mode'),
              ),
              const PopupMenuItem(
                value: 'Toggle Unit',
                child: Text('Toggle Celsius/Fahrenheit'),
              ),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: cityController,
              decoration: const InputDecoration(
                labelText: 'Enter city or zip code',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: fetchWeather,
              child: const Text('Get Weather'),
            ),
            const SizedBox(height: 20),
            if (weather != null)
              WeatherCard(
                weather: weather!,
                isCelsius: isCelsius, // Pass the temperature unit
              ),
          ],
        ),
      ),
    );
  }
}
