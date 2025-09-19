import 'package:flutter/material.dart';

class AppointmentCalendarScreen extends StatelessWidget {
  const AppointmentCalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Choose Date")),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.all(20),
                height: 350,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey[300],
                ),
                child: const Center(child: Text("Calendar placeholder")),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text("Confirm Booking"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
