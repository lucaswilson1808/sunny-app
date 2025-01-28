import 'package:geolocator/geolocator.dart';
import '../models/weather.dart';
import '../services/weather_api.dart';

class WeatherService {
  static Future<Weather?> fetchWeatherForUserLocation() async {
    try {
      LocationPermission permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        throw Exception("Location permission denied.");
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      String location = "${position.latitude},${position.longitude}";
      return await WeatherApi.fetchWeather(location);
    } catch (e) {
      print("Error fetching weather data: $e");
      return null; // Handle error case gracefully
    }
  }
}