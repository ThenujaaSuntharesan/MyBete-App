import 'package:flutter/material.dart';

class RemindersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Reminders"),
          backgroundColor: Color(0xFF5FB8DD),
        ),
        body: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Set Your Reminders",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                ListTile(
                  leading: Icon(Icons.alarm, color: Color(0xFF5EB7CF)),
                  title: Text("No reminders set yet."),
                ),
                SizedBox(height: 20),
                ElevatedButton.icon(
                  icon: Icon(Icons.add_alert),
                  label: Text("Add Reminder"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF5EB7CF),
                  ),
                  onPressed: () {},
                ),
              ],
            ),
            ),
        );
    }
}