import 'package:flutter/material.dart';
import 'package:mybete_app/have_diabetes/DashBoard/profile/change_password_screen.dart';

class AccountSettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Account & Settings"),
        backgroundColor: Color(0xFF5FB8DD),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: CircleAvatar(radius: 50, backgroundColor: Color(0xFF89D0ED))),
            SizedBox(height: 10),
            Text("Email", style: TextStyle(fontWeight: FontWeight.bold)),
            Text("srithiba534@gmail.com"),
            ListTile(
              title: Text("First Name"),
              subtitle: Text("--"),
              onTap: () => _showInputDialog(context, "First Name"),
            ),
            ListTile(
              title: Text("Last Name"),
              subtitle: Text("--"),
              onTap: () => _showInputDialog(context, "Last Name"),
            ),
            ListTile(
              title: Text("Date of Birth"),
              subtitle: Text("--"),
              onTap: () => _selectDate(context),
            ),
            ListTile(
              leading: Icon(Icons.lock, color: Color(0xFF5EB7CF)),
              title: Text("Change Password"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChangePasswordScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.logout, color: Color(0xFF5EB7CF)),
              title: Text("Log Out"),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.delete, color: Colors.red),
              title: Text("Delete my account", style: TextStyle(color: Colors.red)),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  void _showInputDialog(BuildContext context, String field) {
    TextEditingController controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Please enter your $field"),
          content: TextField(controller: controller, decoration: InputDecoration(labelText: field)),
          actions: [
            TextButton(child: Text("Cancel"), onPressed: () => Navigator.pop(context)),
            TextButton(child: Text("Save"), onPressed: () => Navigator.pop(context)),
          ],
        );
      },
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
  }
}
