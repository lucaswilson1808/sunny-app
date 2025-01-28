import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather.dart';

class WeatherApi {
  static const String _apiKey = 'e459f4e645e44ecfa99222743242011';

  // Fetch current weather and forecast
  static Future<Weather?> fetchWeather(String city) async {
    final currentWeatherUrl =
        Uri.parse('http://api.weatherapi.com/v1/current.json?key=$_apiKey&q=$city&aqi=yes');
    final forecastUrl =
        Uri.parse('http://api.weatherapi.com/v1/forecast.json?key=$_apiKey&q=$city&days=3&aqi=no&alerts=no');

    try {
      // Fetch current weather
      final currentWeatherResponse = await http.get(currentWeatherUrl);
      if (currentWeatherResponse.statusCode != 200) {
        print('Error fetching current weather: ${currentWeatherResponse.statusCode}');
        return null;
      }

      final currentWeatherData = jsonDecode(currentWeatherResponse.body);

      // Fetch 3-day forecast
      final forecastResponse = await http.get(forecastUrl);
      if (forecastResponse.statusCode != 200) {
        print('Error fetching forecast: ${forecastResponse.statusCode}');
        return null;
      }

      final forecastData = jsonDecode(forecastResponse.body);

      // Combine current weather and forecast
      return Weather.fromJsonWithForecast(currentWeatherData, forecastData['forecast']['forecastday']);
    } catch (e) {
      print('Error fetching weather data: $e');
      return null;
    }
  }
}