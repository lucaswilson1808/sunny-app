import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'landing_screen.dart';
import 'search_screen.dart';
import 'account_screen.dart';
import '../services/weather_api.dart';
import '../models/weather.dart';
import 'forecast_screen.dart';

class MainScreen extends StatefulWidget {
  final VoidCallback onToggleTheme;

  const MainScreen({Key? key, required this.onToggleTheme}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  Weather? _weather;
  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _initializePages();
    _fetchWeatherForCurrentLocation();
  }

  void _initializePages() {
    _pages = [
      LandingScreen(),
      SearchScreen(onToggleTheme: widget.onToggleTheme),
      const AccountScreen(),
      const Center(child: CircularProgressIndicator()),
    ];
  }

  Future<void> _fetchWeatherForCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      String location = "${position.latitude},${position.longitude}";
      Weather? weather = await WeatherApi.fetchWeather(location);

      if (weather != null) {
        setState(() {
          _weather = weather;
          _pages[3] = ForecastScreen(weather: _weather!);
        });
      }
    } catch (e) {
      setState(() {
        _weather = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        backgroundColor: Colors.white,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Account',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Forecast',
          ),
        ],
      ),
    );
  }
}