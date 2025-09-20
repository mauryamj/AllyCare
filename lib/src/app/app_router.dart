import 'package:flutter/material.dart';
import '../features/auth/presentation/login_screen.dart';
import '../features/auth/presentation/splash_screen.dart';
import '../features/assessment/presentation/assessment_list_screen.dart';
import '../features/assessment/presentation/assessment_detail_screen.dart';
import '../features/appointments/presentation/appointments_screen.dart';
import '../features/challenges/presentation/challenges_screen.dart';
import '../features/workouts/presentation/workouts_screen.dart';
import 'routes.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case AppRoutes.assessments:
        return MaterialPageRoute(builder: (_) => const AssessmentListScreen());
      case AppRoutes.assessmentDetail:
        return MaterialPageRoute(
          builder: (_) => const AssessmentDetailScreen(),
        );
      case AppRoutes.appointments:
        return MaterialPageRoute(builder: (_) => const AppointmentsScreen());
      case AppRoutes.challenges:
        return MaterialPageRoute(builder: (_) => const ChallengesScreen());
      case AppRoutes.workouts:
        return MaterialPageRoute(builder: (_) => const WorkoutsScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Unknown Route')),
          ),
        );
    }
  }
}
