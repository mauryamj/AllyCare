import 'package:flutter/material.dart';

class AppointmentCalendarScreen extends StatelessWidget {
  const AppointmentCalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calendar')),
      body: const Center(
        child: Text('Calendar view goes here'),
      ),
    );
  }
}
