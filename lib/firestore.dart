import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addUser({
    required String uid,
    required String username,
    required String phone,
    required String age,
    required String gender,
    String? email,
  }) async {
    try {
      await _db.collection('users').doc(uid).set({
        'username': username,
        'phone': phone,
        'age': age,
        'gender': gender,
        'email': email,
      });
    } catch (e) {
      print('Error adding user: $e');
    }
  }
}