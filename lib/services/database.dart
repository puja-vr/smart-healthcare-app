import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smarthealthcare/services/user.dart';

class DatabaseService {
  final String uid;
  late String pid;
  DatabaseService({this.uid = ''});

  // collection reference
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference productCollection =
      FirebaseFirestore.instance.collection('categories');
  final CollectionReference blogCollection =
      FirebaseFirestore.instance.collection('blogs');

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  String getUserId() {
    return _firebaseAuth.currentUser!.uid;
  }

  Future<void> updateUserData(String name, String email, int phone,
      String address, int weight, double height, DateTime date) async {
    return await userCollection.doc(uid).set({
      'uid': uid,
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
      'weight': weight,
      'height': height,
      'date': date,
    });
  }

  Future<void> updateUserWeight(int weight) async {
    return await userCollection.doc(uid).update({
      'weight': weight,
    });
  }

  Future<void> updateUserHeight(double height) async {
    return await userCollection.doc(uid).update({
      'height': height,
    });
  }

  Future<void> updateUserDate(DateTime date) async {
    return await userCollection.doc(uid).update({
      'date': date,
    });
  }

  Future<void> updateUserName(String name) async {
    return await userCollection.doc(uid).update({
      'name': name,
    });
  }

  Future<void> updateUserPhone(int ph) async {
    return await userCollection.doc(uid).update({
      'phone': ph,
    });
  }

  Future<void> updateUserAddress(String ad) async {
    return await userCollection.doc(uid).update({
      'address': ad,
    });
  }

  Future<void> updateBlogLikes(String id, int likes) async {
    return await blogCollection.doc(id).update({'likes': likes + 1});
  }

  Future addToCart({required id, required pid}) {
    return userCollection
        .doc(getUserId())
        .collection("Cart")
        .doc(id)
        .set({'pid': pid});
  }

  Future removeFromCart({required id}) {
    return userCollection.doc(getUserId()).collection("Cart").doc(id).delete();
  }

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        uid: uid,
        name: snapshot['name'],
        email: snapshot['email'],
        phone: snapshot['phone'],
        address: snapshot['address'],
        weight: snapshot['weight'],
        height: snapshot['height'],
        date: snapshot['date']);
  }

  Stream<UserData> get userData {
    return userCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}
