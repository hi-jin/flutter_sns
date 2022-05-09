import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final currentPageProvider = StateProvider<int>((ref) => 0);
final userProvider = StateNotifierProvider<UserNotifier, User?>((ref) => UserNotifier(null));



class UserNotifier extends StateNotifier<User?> {
  UserNotifier(state) : super(state);

  Future<void> login(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      state = FirebaseAuth.instance.currentUser;
    } catch (_) {
      rethrow;
    }
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    state = FirebaseAuth.instance.currentUser;
  }

  Future<void> register(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      state = FirebaseAuth.instance.currentUser;
    } catch (_) {
      rethrow;
    }
  }
}
