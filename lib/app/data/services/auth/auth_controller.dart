import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_template_flutter/app/data/services/auth/auth_service.dart';
import 'package:firebase_template_flutter/app/data/services/user/user_controller.dart';
import 'package:firebase_template_flutter/app/utils/helper.dart';
import 'package:firebase_template_flutter/app/utils/print_log_mixin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthenticationController extends GetxController with PrintLogMixin {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  final AuthenticationService _authenticationService = AuthenticationService();

  final Rxn<User> _firebaseUser = Rxn<User>();

  User get user => _firebaseUser.value!;
  User setUser(User user) => _firebaseUser.value = user;

  @override
  void onInit() {
    _firebaseUser.bindStream(_firebaseAuth
        .authStateChanges()); // Bind fireUser changes to Authentication Service
    super.onInit();
  }

  void _createUser(
    UserCredential _authResult,
  ) async {
    final UserController _userController = UserController();
    try {
      await _userController.createUser(
        id: _authResult.user!.uid,
        email: _authResult.user!.email!,
      );

      setUser(_firebaseAuth.currentUser!);
    } catch (e) {
      printLog(e);
      Helpers.showSnackbar(
          title: "Error",
          message: e.toString(),
          color: Colors.red,
          icon: Icon(Icons.cancel_outlined));
    }
  }

  Future<void> register(
      {required String email, required String password}) async {
    try {
      UserCredential _userCredential = await _authenticationService
          .registerUser(email: email.trim(), password: password.trim());
      if (_userCredential.user != null) {
        _createUser(_userCredential);
      }
    } catch (e) {
      printLog(e);
      Helpers.showSnackbar(
          title: "Error",
          message: e.toString(),
          color: Colors.red,
          icon: Icon(Icons.cancel_outlined));
    }
  }

  // LoginUser

  Future<void> login(String email, String password) async {
    try {
      UserCredential _userCredintial = await _authenticationService.loginUser(
          email: email.trim(), password: password.trim());

      if (_userCredintial.user != null) {
        _createUser(_userCredintial);
      }
    } on FirebaseAuthException catch (e) {
      printLog(e);
      if (e.code == "user-not-found") {
        Helpers.showSnackbar(
            title: "Error",
            message: "User not found",
            color: Colors.red,
            icon: Icon(Icons.cancel_outlined));
      } else if (e.code == "wrong-password") {
        Helpers.showSnackbar(
            title: "Error",
            message: "Wrong password",
            color: Colors.red,
            icon: Icon(Icons.cancel_outlined));
      } else if (e.code == "invalid-email") {
        Helpers.showSnackbar(
            title: "Error",
            message: "Invalid Email",
            color: Colors.red,
            icon: Icon(Icons.cancel_outlined));
      }
    } catch (e) {
      printLog(e);
      Helpers.showSnackbar(
          title: "Error",
          message: e.toString(),
          color: Colors.red,
          icon: Icon(Icons.cancel_outlined));
    }
  }

  // LOGOUT

  Future<void> signOut() async {
    try {
      await _authenticationService.signOutUser();
    } catch (e) {
      printLog(e);
      Helpers.showSnackbar(
          title: "Error",
          message: e.toString(),
          color: Colors.red,
          icon: Icon(Icons.cancel_outlined));
    }
  }

  // Forgot Passowrd

  Future<void> forgotPassword({required String email}) async {
    try {
      await _authenticationService.forgotPassword(email: email.trim());
    } catch (e) {
      printLog(e);
      Helpers.showSnackbar(
          title: "Error",
          message: e.toString(),
          color: Colors.red,
          icon: Icon(Icons.cancel_outlined));
    }
  }
}
