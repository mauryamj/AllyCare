import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/data/database_service.dart';

final databaseServiceProvider =
    Provider<DatabaseService>((ref) => DatabaseService());

final appointmentsProvider =
    StreamProvider.autoDispose<List<Map<String, dynamic>>>((ref) {
  final db = ref.watch(databaseServiceProvider);
  // Replace with actual userId from auth
  return db.getAppointments("dummyUserId");
});

// Optional: Booking provider to write appointments
final bookingProvider =
    FutureProvider.family<void, Map<String, dynamic>>((ref, data) async {
  final db = ref.watch(databaseServiceProvider);
  await db.createAppointment(data); // Implement createAppointment in DatabaseService
});
