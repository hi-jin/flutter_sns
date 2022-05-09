import 'package:firebase_auth/firebase_auth.dart' as fb;

class AppUser {
  static final auth = fb.FirebaseAuth.instance;
  static fb.User? currentUser;

  static Future<fb.User?> login(String email, String password) async {
    try {
      final result = await auth.signInWithEmailAndPassword(email: email, password: password);
      currentUser = result.user;

    } catch(_) {
      rethrow;
    }
    return currentUser;
  }

  static Future<fb.User?> register(String email, String password) async {
    try {
      final result = await auth.createUserWithEmailAndPassword(email: email, password: password);
      currentUser = result.user;
    } catch(_) {
      rethrow;
    }

    return currentUser;
  }

  static void logout() {
    currentUser = null;
  }
}