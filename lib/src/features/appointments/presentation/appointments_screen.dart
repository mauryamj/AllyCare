import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'providers/appointment_providers.dart';
import '../../../app/routes.dart';

class AppointmentsScreen extends ConsumerWidget {
  const AppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appointmentsAsync = ref.watch(appointmentsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Appointments')),
      body: appointmentsAsync.when(
        data: (appointments) => ListView.builder(
          itemCount: appointments.length,
          itemBuilder: (context, index) {
            final a = appointments[index];
            return ListTile(
              title: Text(a['title'] ?? ''),
              subtitle: Text(a['date'] ?? ''),
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.calendar);
              },
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('Error: $err')),
      ),
    );
  }
}
