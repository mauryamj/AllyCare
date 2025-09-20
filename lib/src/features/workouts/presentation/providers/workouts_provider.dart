import '../../../assessment/presentation/providers/assessment_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
final workoutsProvider =
    StreamProvider.autoDispose<List<Map<String, dynamic>>>(
        (ref) => ref.watch(databaseServiceProvider).getWorkouts());
