import 'package:flutter/material.dart';

class SupportFeedbackScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ask Support"),
        backgroundColor: Color(0xFF5FB8DD),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(decoration: InputDecoration(hintText: "Send us a message")),
            SizedBox(height: 20),
            ElevatedButton(onPressed: () {}, child: Text("Send")),
          ],
        ),
      ),
    );
  }
}
