import 'package:flutter/material.dart';
import 'package:sunny/screens/landing_screen.dart';
import 'package:sunny/screens/search_screen.dart';
import 'package:sunny/screens/account_screen.dart';
import 'package:sunny/screens/forecast_screen.dart';
import 'package:sunny/services/logout.dart';
import '../models/weather.dart';

class MainScreen extends StatefulWidget {
  final VoidCallback onToggleTheme;
  final Weather weather;

  const MainScreen(
      {Key? key, required this.onToggleTheme, required this.weather})
      : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  bool isCelsius = true;

  void toggleTemperatureUnit() {
    setState(() {
      isCelsius = !isCelsius;
    });
  }

  void switchToSearch() {
    setState(() {
      _currentIndex = 1;
    });
  }

  String get _currentTitle {
    switch (_currentIndex) {
      case 0:
        return "Welcome to Sunny!";
      case 1:
        return "Location Search";
      case 2:
        return "Your Account";
      case 3:
        return "3-Day Forecast";
      default:
        return "Sunny";
    }
  }

  List<Widget> get _pages => [
        LandingScreen(
            weather: widget.weather,
            isCelsius: isCelsius,
            onSearchPressed: switchToSearch),
        SearchScreen(isCelsius: isCelsius),
        const AccountScreen(),
        ForecastScreen(weather: widget.weather),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_currentTitle),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'Toggle Theme') {
                widget.onToggleTheme();
              } else if (value == 'Toggle Unit') {
                toggleTemperatureUnit();
              } else if (value == 'Logout') {
                AuthService.logout(context);
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
              const PopupMenuItem(
                value: 'Logout',
                child: Text('Logout'),
              ),
            ],
          ),
        ],
      ),
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
