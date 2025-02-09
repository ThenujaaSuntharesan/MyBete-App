import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class diabeteOptions extends StatelessWidget {
  const diabeteOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
            onPressed: () async{
              final prefs = await SharedPreferences.getInstance();
              prefs.setBool("onboarding", false);
            },
            child: Text("enable onboarding")),
      ),
    );
  }
}
