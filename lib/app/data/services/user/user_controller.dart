import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_template_flutter/app/data/services/auth/auth_controller.dart';
import 'package:firebase_template_flutter/app/data/services/user/user_service.dart';
import 'package:firebase_template_flutter/app/models/user_model.dart';
import 'package:firebase_template_flutter/app/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  @override
  void onInit() {
    fetchUser();
    super.onInit();
  }

  final UserService _userService = UserService();
  final AuthenticationController _authenticationController =
      Get.find<AuthenticationController>();

  Stream<DocumentSnapshot> fetchUser() {
    Stream<DocumentSnapshot> qSnapStream =
        _userService.fetchUser(_authenticationController.user.uid);
    return qSnapStream;
  }

  Future<void> createUser({
    required String email,
    required String id,
  }) async {
    try {
      User user = User(
        id: _authenticationController.user.uid,
        email: email,
      );
      await _userService.createNewUser(user);
    } catch (e) {
      Helpers.showSnackbar(
          title: "Error",
          message: e.toString(),
          color: Colors.red,
          icon: Icon(Icons.cancel_outlined));
    }
  }
}
