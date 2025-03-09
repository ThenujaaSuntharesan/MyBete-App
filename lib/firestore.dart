import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addUser({
    required String uid,
    required String username,
    required String email,
    required String age,
    required String gender,
  }) async {
    try {
      // Store user data with username as document ID
      await _db.collection('users').doc(username).set({
        'uid': uid,
        'email': email,
        'username': username,
        'age': age,
        'gender': gender,
      });

      // Map username to UID
      await _db.collection('usernames').doc(username).set({
        'uid': uid,
      });

      print('User added successfully');
    } catch (e) {
      print('Error adding user: $e');
      throw e;
    }
  }
}

