import 'package:flutter/material.dart';
import '../services/weather_api.dart';
import '../models/weather.dart';
import '../widgets/weather_card.dart';

class SearchScreen extends StatefulWidget {
  final bool isCelsius;

  const SearchScreen({Key? key, required this.isCelsius}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  Weather? weather;
  final TextEditingController cityController = TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.20),
      child: Column(
        children: [
          const SizedBox(height: 20),
          TextField(
            controller: cityController,
            decoration: const InputDecoration(
              labelText: 'Enter city or zip code',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 50),
          ElevatedButton(
            style: ElevatedButton.styleFrom(minimumSize: const Size(200, 50)),
            onPressed: fetchWeather,
            child: const Text('Get Weather',style: TextStyle(fontSize: 18)),
          ),
          const SizedBox(height: 40),
          if (weather != null)
            WeatherCard(
              weather: weather!,
              isCelsius: widget.isCelsius,
            ),
        ],
      ),
    );
  }
}