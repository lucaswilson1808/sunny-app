import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sunny/screens/account_screen.dart';
import 'package:sunny/screens/landing_screen.dart';
import 'package:sunny/screens/main_screen.dart';
import 'package:sunny/screens/register_screen.dart';
import 'package:sunny/screens/search_screen.dart';
import 'package:sunny/screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sunny',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white, // Default background color
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.white, // Ensure solid background color
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
        ),
      ),
      darkTheme: ThemeData.dark(),
      themeMode: _themeMode,
      initialRoute: FirebaseAuth.instance.currentUser == null ? '/login' : '/main_screen',
      routes: {
        '/main_screen': (context) => MainScreen(onToggleTheme: toggleTheme),
        '/login': (context) => const LoginScreen(),
        '/landing': (context) => LandingScreen(),
        '/search_screen': (context) => SearchScreen(onToggleTheme: toggleTheme),
        '/account': (context) => const AccountScreen(),
        '/register': (context) => const RegisterScreen(),
      },
    );
  }
}