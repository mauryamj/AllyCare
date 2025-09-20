import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../assessment/presentation/providers/assessment_providers.dart';
final challengesProvider =
    StreamProvider.autoDispose<List<Map<String, dynamic>>>(
        (ref) => ref.watch(databaseServiceProvider).getChallenges());
