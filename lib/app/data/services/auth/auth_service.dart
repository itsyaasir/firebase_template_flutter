import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_template_flutter/app/utils/print_log_mixin.dart';

class AuthenticationService with PrintLogMixin {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

// Register User
  Future<UserCredential> registerUser(
      {required String email, required String password}) async {
    UserCredential userCredential = await _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);
    printLog('userCredential: $userCredential');
    return userCredential;
  }

  // Login User
  Future<UserCredential> loginUser(
      {required String email, required String password}) async {
    UserCredential userCredential = await _firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password);
    printLog(userCredential);
    return userCredential;
  }

  // SingOut User
  Future<void> signOutUser() async {
    await _firebaseAuth.signOut();
  }

  // Forgot Password
  Future<void> forgotPassword({required String email}) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }
}
