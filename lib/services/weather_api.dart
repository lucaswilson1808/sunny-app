import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather.dart';

class WeatherApi {

  static const String _apiKey = 'e459f4e645e44ecfa99222743242011';

  static Future<Weather?> fetchWeather(String city) async {
   final url = Uri.parse('http://api.weatherapi.com/v1/current.json?key=$_apiKey&q=$city&aqi=yes');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      try {
        final data = jsonDecode(response.body);
        return Weather.fromJson(data);
      } catch (e) {
        print('Error parsing weather data: $e');
        return null;
      }
    } else {
      print('Error: ${response.statusCode}');
      print('Response: ${response.body}');
      return null;
    }
  }
}