import 'package:flutter/material.dart';

class AppointmentListScreen extends StatelessWidget {
  const AppointmentListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Appointments")),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 3,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              title: Text("Appointment Option ${index + 1}"),
              subtitle: const Text("Tap to pick date & book"),
              onTap: () => Navigator.pushNamed(context, '/calendar'),
            ),
          );
        },
      ),
    );
  }
}
