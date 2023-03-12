import 'package:cloud_firestore/cloud_firestore.dart';

class MyUser {
  final String uid;

  MyUser({required this.uid});
}

class UserData {
  final String uid;
  final String name;
  final String email;
  final int phone;
  final String address;
  final int weight;
  final double height;
  final Timestamp date;

  UserData(
      {required this.uid,
      required this.name,
      required this.email,
      required this.phone,
      required this.address,
      required this.weight,
      required this.height,
      required this.date});
}
