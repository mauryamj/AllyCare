import 'package:flutter_riverpod/flutter_riverpod.dart';

final challengesProvider = Provider<List<String>>((ref) {
  return ["10k Steps Challenge", "Hydration Streak", "Daily Meditation"];
});

final workoutsProvider = Provider<List<String>>((ref) {
  return ["Full Body Stretch", "Cardio Blast", "Strength Circuit"];
});
