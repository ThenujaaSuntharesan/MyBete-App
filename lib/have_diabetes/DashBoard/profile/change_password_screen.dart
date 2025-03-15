import 'package:flutter/material.dart';

class ChangePasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Change Password"),
        backgroundColor: Color(0xFF5FB8DD),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(decoration: InputDecoration(labelText: "Old password", suffixIcon: Icon(Icons.visibility_off))),
            TextField(decoration: InputDecoration(labelText: "New password", suffixIcon: Icon(Icons.visibility_off))),
            TextField(decoration: InputDecoration(labelText: "Confirm password", suffixIcon: Icon(Icons.visibility_off))),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _showPasswordChangedDialog(context);
              },
              child: Text("Save"),
            ),
          ],
        ),
      ),
    );
  }

  void _showPasswordChangedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Password Changed!"),
          actions: [
            TextButton(child: Text("OK"), onPressed: () => Navigator.pop(context)),
          ],
        );
      },
    );
  }
}
