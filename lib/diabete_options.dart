import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'components/color.dart';
import 'donot_have_diabetes/donot_have_diabete.dart';
import 'have_diabetes/have_diabete_quiz.dart';
import 'not_sure/not_sure.dart';
import 'log_in_screen.dart'; // Import the login screen

class DiabeteOptions extends StatelessWidget {
  const DiabeteOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Diabetes Options"),
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle, size: 50), // Increase the size of the icon
            onPressed: () {
              _showLogoutMenu(context);
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                prefs.setBool("onboarding", false);
              },
              child: Text("Choose one option from these three"),
            ),
            SizedBox(height: 20), // Space between elements
            haveDiabetes(context),
            SizedBox(height: 20),
            doNotHaveDiabetes(context),
            SizedBox(height: 20),
            notSure(context), // Correctly use the button here
          ],
        ),
      ),
    );
  }

  void _showLogoutMenu(BuildContext context) {
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(1000, 80, 0, 0),
      items: [
        PopupMenuItem(
          child: ListTile(
            leading: Icon(Icons.logout),
            title: Text('Log Out'),
            onTap: () async {
              final prefs = await SharedPreferences.getInstance();
              await prefs.setBool('isLoggedIn', false);
              await prefs.remove('lastLoginDate');
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
                    (route) => false,
              );
            },
          ),
        ),
      ],
    );
  }
}

Widget haveDiabetes(BuildContext context) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: Colors.red, // Replace with primaryColor if needed
    ),
    width: 200, // Give it a fixed width
    height: 55,
    child: TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HaveDiabetesDashboard()),
        );
      },
      child: const Text(
        "I have diabetes",
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
    ),
  );
}

Widget doNotHaveDiabetes(BuildContext context) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: Colors.blue, // Replace with primaryColor if needed
    ),
    width: 200, // Give it a fixed width
    height: 55,
    child: TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DonotHaveDiabeteDashboard()),
        );
      },
      child: const Text(
        "I don't have diabetes",
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
    ),
  );
}

Widget notSure(BuildContext context) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: Colors.blue, // Replace with primaryColor if needed
    ),
    width: 200, // Give it a fixed width
    height: 55,
    child: TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NotSureDashboard()),
        );
      },
      child: const Text(
        "I'm not sure",
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
    ),
  );
}