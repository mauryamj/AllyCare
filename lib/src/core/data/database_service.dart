import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  DatabaseService() {
    // Enable offline persistence
    _db.settings = const Settings(
      persistenceEnabled: true,
      cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
    );
  }

  // -------------------- Assessments --------------------
  Stream<List<Map<String, dynamic>>> getAssessments(String userId) {
    return _db
        .collection('assessments')
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map((snap) => snap.docs.map((d) => d.data()).toList());
  }

  // Paginated query for assessments
  Future<List<Map<String, dynamic>>> getAssessmentsPaginated({
    required String userId,
    DocumentSnapshot? lastDoc,
    int limit = 10,
  }) async {
    Query query = _db
        .collection('assessments')
        .where('userId', isEqualTo: userId)
        .orderBy('title')
        .limit(limit);

    if (lastDoc != null) query = query.startAfterDocument(lastDoc);

    final snap = await query.get();
    return snap.docs
      .map((d) => d.data() as Map<String, dynamic>)
      .toList();
  }

  // -------------------- Appointments --------------------
  Stream<List<Map<String, dynamic>>> getAppointments(String userId) {
    return _db
        .collection('appointments')
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map((snap) => snap.docs.map((d) => d.data()).toList());
  }

  Future<void> createAppointment(Map<String, dynamic> data) async {
    await _db.collection('appointments').add(data);
  }

  // -------------------- Challenges --------------------
  Stream<List<Map<String, dynamic>>> getChallenges() {
    return _db.collection('challenges').snapshots().map(
        (snap) => snap.docs.map((d) => d.data()).toList());
  }

  // -------------------- Workouts --------------------
  Stream<List<Map<String, dynamic>>> getWorkouts() {
    return _db.collection('workouts').snapshots().map(
        (snap) => snap.docs.map((d) => d.data()).toList());
  }
}
