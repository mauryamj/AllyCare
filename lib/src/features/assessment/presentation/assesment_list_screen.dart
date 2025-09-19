import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'providers/assessment_toggle_provider.dart';
import 'providers/assessment_content_providers.dart';
import '../../auth/provider/auth_providers.dart';

class AssesmentListScreen extends ConsumerWidget {
  const AssesmentListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(assessmentToggleProvider);
    final user = ref.watch(currentUserProvider);
    final displayName = user?.displayName ?? (user?.email ?? 'User');
    final challenges = ref.watch(challengesProvider);
    final workouts = ref.watch(workoutsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Hello $displayName",
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => ref.read(authServiceProvider).signOut(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            
            Container(
              padding: const EdgeInsets.all(5),
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.grey[200],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () =>
                          ref.read(assessmentToggleProvider.notifier).state = 0,
                      style: TextButton.styleFrom(
                        backgroundColor: selectedIndex == 0
                            ? Colors.white
                            : Colors.transparent,
                        foregroundColor: selectedIndex == 0
                            ? Colors.blue[800]
                            : Colors.black54,
                      ),
                      child: const Text("My Assessments"),
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () =>
                          ref.read(assessmentToggleProvider.notifier).state = 1,
                      style: TextButton.styleFrom(
                        backgroundColor: selectedIndex == 1
                            ? Colors.white
                            : Colors.transparent,
                        foregroundColor: selectedIndex == 1
                            ? Colors.blue[800]
                            : Colors.black54,
                      ),
                      child: const Text("My Appointments"),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            
            if (selectedIndex == 0)
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/assessmentDetail'),
                child: Container(
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.grey[300],
                  ),
                  child: const Center(
                    child: Text("Assessment Card Placeholder"),
                  ),
                ),
              )
            else
              Container(
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.grey[300],
                ),
                child: const Center(
                  child: Text("Appointment Card Placeholder"),
                ),
              ),

            const SizedBox(height: 20),

            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "Challenges",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text("View All"),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 130,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: challenges.length,
                separatorBuilder: (_, __) => const SizedBox(width: 10),
                itemBuilder: (context, index) {
                  return Container(
                    width: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.orange[100],
                    ),
                    child: Center(child: Text(challenges[index])),
                  );
                },
              ),
            ),

            const SizedBox(height: 20),

            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "Workout routines",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text("View All"),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 130,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: workouts.length,
                separatorBuilder: (_, __) => const SizedBox(width: 10),
                itemBuilder: (context, index) {
                  return Container(
                    width: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.green[100],
                    ),
                    child: Center(child: Text(workouts[index])),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
