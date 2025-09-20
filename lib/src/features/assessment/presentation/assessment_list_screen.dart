import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../auth/presentation/providers/auth_providers.dart';
import 'providers/assessment_providers.dart';

class AssessmentListScreen extends ConsumerWidget {
  const AssessmentListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(assessmentToggleProvider);
    final user = ref.watch(currentUserProvider);
    final displayName = user?.displayName ?? (user?.email ?? 'User');

    final assessmentsAsync = ref.watch(assessmentsProvider);
    final favorites = ref.watch(favoritesProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Hello $displayName",
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await ref.read(authServiceProvider).signOut();
              if (!context.mounted) return;
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/login',
                (route) => false,
              );
            },
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
              assessmentsAsync.when(
                data: (assessments) => assessments.isEmpty
                    ? GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/assessmentDetail');
                        },
                        child: Container(
                          height: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.grey[300],
                          ),
                          child: Center(
                            child: Center(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Image.asset(
                                      'assets/images/chracter_image_template/sit.png',
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 15.0,
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Health Risk Assessment ",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17,
                                            ),
                                          ),
                                          Text(
                                            "Identify risk with precise,proactive assessment",
                                            style: TextStyle(),
                                          ),

                                          ElevatedButton(
                                            onPressed: () {},

                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  Colors.transparent,
                                              padding: EdgeInsets.zero,
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                left: 6.0,
                                                right: 12,
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,

                                                children: [
                                                  Icon(
                                                    Icons
                                                        .play_circle_fill_outlined,
                                                    color: Colors.blue[600],
                                                    size: 30,
                                                  ),
                                                  const SizedBox(width: 8),
                                                  Text(
                                                    "Start",
                                                    style: TextStyle(
                                                      color: Colors.blue[600],
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    : ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: assessments.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final assessment = assessments[index];
                          final isFav = favorites.contains(assessment['id']);
                          return GestureDetector(
                            onTap: () => Navigator.pushNamed(
                              context,
                              '/assessmentDetail',
                            ),
                            child: Container(
                              height: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: Colors.grey[300],
                              ),
                              child: Stack(
                                children: [
                                  Center(
                                    child: Text(
                                      assessment['title'] ?? "Assessment",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 8,
                                    right: 8,
                                    child: IconButton(
                                      icon: Icon(
                                        isFav
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        color: isFav ? Colors.red : Colors.grey,
                                      ),
                                      onPressed: () => ref
                                          .read(favoritesProvider.notifier)
                                          .toggleFavorite(assessment['id']),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, _) => Center(child: Text('Error: $err')),
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
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.green[100],
                ),
                child: Center(
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Today's Challenge! ",
                                style: TextStyle(
                                  color: Colors.green[800],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.green[800],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0,
                                    vertical: 3.0,
                                  ),
                                  child: Text(
                                    "Push Up 20x",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),

                              SliderTheme(
                                data: SliderTheme.of(context).copyWith(
                                  thumbShape: SliderComponentShape.noThumb,
                                  trackHeight: 4,
                                  padding: EdgeInsets.zero,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Slider(
                                    value: 5,
                                    max: 10,
                                    divisions: 10,
                                    onChanged: (value) {},
                                  ),
                                ),
                              ),

                              ElevatedButton(
                                onPressed: () {},

                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  padding: EdgeInsets.zero,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 6.0,
                                    right: 12,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,

                                    children: [
                                      Icon(
                                        Icons.play_circle_fill_outlined,
                                        color: Colors.blue[600],
                                        size: 30,
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        "Continue",
                                        style: TextStyle(
                                          color: Colors.blue[600],
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Image.asset(
                          'assets/images/chracter_image_template/pushup.png',
                        ),
                      ),
                    ],
                  ),
                ),
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
                itemCount: 5,
                separatorBuilder: (_, __) => const SizedBox(width: 10),
                itemBuilder: (context, index) {
                  return Container(
                    width: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.green[100],
                    ),
                    child: Center(child: Text("Workout ${index + 1}")),
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
