import 'package:flutter/material.dart';
import '../features/auth/presentation/login_screen.dart';
import '../features/auth/presentation/splash_screen.dart';
import '../features/assessment/presentation/assesment_list_screen.dart';
import '../features/assessment/presentation/assesment_detail_screen.dart';
import '../features/appointment/presentation/appointment_list_screen.dart';
import '../features/appointment/presentation/appointment_calendar_screen.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case '/login':
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      case '/assessments':
        return MaterialPageRoute(builder: (_) => const AssesmentListScreen());

      case '/assessmentDetail':
        return MaterialPageRoute(
          builder: (_) => const AssesmentDetailScreen(),
        );

      case '/appointments':
        return MaterialPageRoute(builder: (_) => const AppointmentListScreen());

      case '/calendar':
        return MaterialPageRoute(
          builder: (_) => const AppointmentCalendarScreen(),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Page not found')),
          ),
        );
    }
  }
}
