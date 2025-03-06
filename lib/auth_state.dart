import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mybete_app/log_in_screen.dart';
import 'diabete_options.dart';

class AuthState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(child: Text('Something went wrong. Please try again later.')),
          );
        } else if (snapshot.hasData) {
          return DiabeteOptions();
        } else {
          return LoginPage();
        }
      },
    );
  }
}