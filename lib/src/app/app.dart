import 'package:allycare/src/app/app_router.dart';
import 'package:allycare/src/features/auth/presentation/login_screen.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AllyCare',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: LoginScreen(),
      onGenerateRoute: AppRouter.generateRoute,
      initialRoute: '/',
    );
  }
}
