import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../services/weather_api.dart';
import '../models/weather.dart';

class LandingScreen extends StatefulWidget {
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  String locationMessage = "Fetching your location...";
  Weather? currentWeather;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchWeatherForCurrentLocation();
  }

  Future<void> _fetchWeatherForCurrentLocation() async {
    try {
      // Ensure location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() {
          locationMessage = "Location services are disabled.";
          isLoading = false;
        });
        return;
      }

      // Request location permissions
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          setState(() {
            locationMessage = "Location permission denied.";
            isLoading = false;
          });
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        setState(() {
          locationMessage =
              "Location permissions are permanently denied. Please enable them in settings.";
          isLoading = false;
        });
        return;
      }

      // Get the current location
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      setState(() {
        locationMessage =
            "Lat: ${position.latitude}, Long: ${position.longitude}";
      });

      // Fetch weather data using WeatherApi
      final weather = await WeatherApi.fetchWeather(
          '${position.latitude},${position.longitude}');

      setState(() {
        currentWeather = weather;
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        locationMessage = "Error fetching location or weather: $error";
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome to Sunny!', 
        style: TextStyle(
          color: Color.fromARGB(255, 67, 22, 6)),
          ),
      backgroundColor: const Color.fromARGB(255, 197, 127, 230),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/landing');
          },
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'Logout') {
                Navigator.pushReplacementNamed(context,'/login');
              } 
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'Logout',
                child: Text('Logout'),
              ),
            ],
          ),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : currentWeather != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Weather in ${currentWeather!.city}, ${currentWeather!.region}:",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 10),
                      Text(
                        "${currentWeather!.condition}",
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        "Temperature: ${currentWeather!.temperature.toStringAsFixed(1)}°C",
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(height: 40),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/search_screen');
                        },
                        child: Text('Search for a Location'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/login');
                        },
                        child: Text('Logout'),
                      ),
                    ],
                  ),
                )
              : Center(
                  child: Text(
                    locationMessage,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
    );
  }
}