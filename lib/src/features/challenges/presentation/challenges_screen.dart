import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'providers/challenges_provider.dart';

class ChallengesScreen extends ConsumerWidget {
  const ChallengesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final challengesAsync = ref.watch(challengesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Challenges')),
      body: challengesAsync.when(
        data: (challenges) => ListView.builder(
          itemCount: challenges.length,
          itemBuilder: (context, index) {
            final c = challenges[index];
            return Card(
              child: ListTile(
                title: Text(c['title'] ?? ''),
                subtitle: Text(c['description'] ?? ''),
              ),
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('Error: $err')),
      ),
    );
  }
}
