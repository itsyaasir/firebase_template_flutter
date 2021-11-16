import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_template_flutter/app/models/user_model.dart';
import 'package:firebase_template_flutter/app/utils/print_log_mixin.dart';

class UserService with PrintLogMixin {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User> createNewUser(User user) async {
    await _firestore.collection("user").doc(user.id).set({
      "id": user.id,
      "email": user.email,
    });
    return user;
  }

  Stream<DocumentSnapshot> fetchUser(String? uid) {
    return _firestore.collection("user").doc(uid.toString()).snapshots();
  }
}
