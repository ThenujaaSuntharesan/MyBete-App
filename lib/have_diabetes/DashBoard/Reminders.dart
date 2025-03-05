
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RemindersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Reminders")),
      body: Center(child: Text("No reminders set yet.")),
    );
  }
}


