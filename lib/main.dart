import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; // Import Firebase core package
import 'package:sunny/screens/account_screen.dart';
import 'package:sunny/screens/landing_screen.dart';
import 'package:sunny/screens/register_screen.dart';
import 'package:sunny/screens/search_screen.dart';
import 'package:sunny/screens/login_screen.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Firebase
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
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: _themeMode,
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/landing': (context) => LandingScreen(),
        '/search_screen': (context) => SearchScreen(onToggleTheme: toggleTheme),
        '/account': (context) => const AccountScreen(),
        '/register': (context) => const RegisterScreen(),
      },
    );
  }
}
