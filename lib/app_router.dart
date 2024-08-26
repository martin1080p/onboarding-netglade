import 'package:flutter/material.dart';
import 'package:onboarding/screens/initial_screen.dart';
import 'package:onboarding/screens/login_screen.dart';
import 'package:onboarding/screens/home_screen.dart';
import 'package:onboarding/screens/register_screen.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/home':
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case '/register':
        return MaterialPageRoute(builder: (_) => RegisterScreen());
      case '/login':
        return MaterialPageRoute(builder: (_) => LoginScreen());
      default:
        return MaterialPageRoute(builder: (_) => const InitialScreen());
    }
  }
}
