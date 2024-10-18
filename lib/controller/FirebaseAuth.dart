import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// مزود لـ Firebase Authentication
final firebaseAuthProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});

// مزود لتسجيل المستخدم
final authProvider = Provider<AuthService>((ref) {
  final auth = ref.watch(firebaseAuthProvider);
  return AuthService(auth);
});

// خدمة تسجيل المستخدم
class AuthService {
  final FirebaseAuth _auth;

  AuthService(this._auth);

  Future<User?> register(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      throw e; // يمكنك تحسين التعامل مع الأخطاء هنا
    }
  }

// خدمة تسجيل الدخول
  Future<User?> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      throw e; // يمكنك تحسين التعامل مع الأخطاء هنا
    }
  }
}