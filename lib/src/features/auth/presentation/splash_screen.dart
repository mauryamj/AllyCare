import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../provider/auth_providers.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(authStateChangesProvider, (previous, next) {
      next.whenData((user) {
        if (user != null) {
          Navigator.pushReplacementNamed(context, '/assessments');
        } else {
          Navigator.pushReplacementNamed(context, '/login');
        }
      });
    });

    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
