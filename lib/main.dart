import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sunny/screens/account_screen.dart';
import 'package:sunny/screens/landing_screen.dart';
import 'package:sunny/screens/main_screen.dart';
import 'package:sunny/screens/register_screen.dart';
import 'package:sunny/screens/search_screen.dart';
import 'package:sunny/screens/login_screen.dart';
import '../models/weather.dart';
import '../services/weather_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  Weather? initialWeather = await WeatherService.fetchWeatherForUserLocation();

  runApp(MyApp(initialWeather: initialWeather));
}

class MyApp extends StatefulWidget {
  final Weather? initialWeather;

  const MyApp({Key? key, required this.initialWeather}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void toggleTheme() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  void switchToSearch(BuildContext context) {
    Navigator.pushNamed(context, '/main_screen', arguments: 1);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sunny',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
        ),
      ),
      darkTheme: ThemeData.dark(),
      themeMode: _themeMode,
      initialRoute:
          FirebaseAuth.instance.currentUser == null ? '/login' : '/main_screen',
      routes: {
        '/main_screen': (context) => MainScreen(
              onToggleTheme: toggleTheme,
              weather: widget.initialWeather!,
            ),
        '/login': (context) => const LoginScreen(),
        '/landing': (context) => LandingScreen(
              weather: widget.initialWeather!,
              isCelsius: true,
              onSearchPressed: () => switchToSearch(context),
            ),
        '/search_screen': (context) => SearchScreen(
              isCelsius: true,
            ),
        '/account': (context) => const AccountScreen(),
        '/register': (context) => const RegisterScreen(),
      },
    );
  }
}
