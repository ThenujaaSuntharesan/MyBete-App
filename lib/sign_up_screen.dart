import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'log_in_screen.dart';
import 'diabete_options.dart';
import 'firestore.dart'; // Import your FirestoreService

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController(); // Add phone controller
  String _gender = 'Male';

  final FirestoreService _firestoreService = FirestoreService();

  Future<void> _signUp() async {
    try {
      // Check if the username is already taken
      DocumentSnapshot usernameSnapshot = await FirebaseFirestore.instance
          .collection('usernames')
          .doc(_usernameController.text)
          .get();

      if (usernameSnapshot.exists) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Username is already taken.')));
        return;
      }

      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      // Store user data with username as document ID
      await _firestoreService.addUser(
        uid: userCredential.user!.uid,
        username: _usernameController.text,
        phone: _phoneController.text,
        age: _ageController.text,
        gender: _gender,
        email: _emailController.text,
      );

      // Map username to UID
      await FirebaseFirestore.instance.collection('usernames').doc(_usernameController.text).set({
        'uid': userCredential.user!.uid,
      });

      // Set logged-in flag in SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => DiabeteOptions()),
      );
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'email-already-in-use':
          errorMessage = 'The email address is already in use by another account.';
          break;
        case 'invalid-email':
          errorMessage = 'The email address is not valid.';
          break;
        case 'weak-password':
          errorMessage = 'The password is too weak.';
          break;
        default:
          errorMessage = 'An unexpected error occurred. Please try again.';
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(errorMessage)));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('An unexpected error occurred. Please try again.')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign Up')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            TextField(
              controller: _ageController,
              decoration: InputDecoration(labelText: 'Age'),
            ),
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(labelText: 'Phone'), // Add phone input
            ),
            DropdownButton<String>(
              value: _gender,
              onChanged: (String? newValue) {
                setState(() {
                  _gender = newValue!;
                });
              },
              items: <String>['Male', 'Female', 'Other']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            ElevatedButton(
              onPressed: _signUp,
              child: Text('Sign Up'),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              child: Text('Already have an account? Log in'),
            ),
          ],
        ),
      ),
    );
  }
}