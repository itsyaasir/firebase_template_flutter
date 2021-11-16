import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  List<User>? user;
  UserModel({required this.user});

  // From JSON
  UserModel.fromJson(Map<String, dynamic> json) {
    if (json['user'] != null) {
      user = List<User>.empty(); // Initialize an empty list
      json['user'].forEach((v) {
        user!.add(User.fromJson(v));
      });
    }
  }

  // To JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (user != null) {
      data['user'] = user!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class User {
  late String id;
  late String email;

  User({required this.id, required this.email});

  User.fromDocument(DocumentSnapshot documentSnapshot) {
    id = documentSnapshot.id;
    email = documentSnapshot['email'] as String;
  }

  User.fromQueryDocumentSnapshot(QueryDocumentSnapshot documentSnapshot) {
    id = documentSnapshot.id;
    email = documentSnapshot['email'] as String;
  }

  // To JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    return data;
  }

  // From Json
  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
  }
}
