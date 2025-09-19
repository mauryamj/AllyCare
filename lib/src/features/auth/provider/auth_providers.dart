import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

final authServiceProvider = Provider<AuthService>((ref) => AuthService());

final authStateChangesProvider = StreamProvider<User?>((ref) {
  final svc = ref.read(authServiceProvider);
  return svc.authStateChanges;
});

final currentUserProvider = Provider<User?>((ref) {
  final asyncUser = ref.watch(authStateChangesProvider);
  return asyncUser.whenOrNull(data: (u) => u) ?? null;
});
