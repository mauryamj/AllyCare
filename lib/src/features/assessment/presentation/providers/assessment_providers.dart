import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/data/database_service.dart';
class FavoritesNotifier extends StateNotifier<Set<String>> {
  FavoritesNotifier() : super(<String>{}) {
    _loadFavorites();
  }

  void _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favList = prefs.getStringList('favorites') ?? [];
    state = favList.toSet();
  }

  void toggleFavorite(String id) async {
    final newSet = Set<String>.from(state);
    if (newSet.contains(id)) {
      newSet.remove(id);
    } else {
      newSet.add(id);
    }
    state = newSet;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('favorites', newSet.toList());
  }
}


final databaseServiceProvider =
    Provider<DatabaseService>((ref) => DatabaseService());

final assessmentsProvider =
    StreamProvider.autoDispose<List<Map<String, dynamic>>>((ref) {
  final db = ref.watch(databaseServiceProvider);
  return db.getAssessments("dummyUserId"); // replace later with userId
});

final favoritesProvider =
    StateNotifierProvider<FavoritesNotifier, Set<String>>(
        (ref) => FavoritesNotifier());
final assessmentToggleProvider = StateProvider<int>((ref) => 0);