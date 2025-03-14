import 'package:flutter/material.dart';
import 'package:mybete_app/have_diabetes/DashBoard/profile/account_settings_screen.dart';
import 'package:mybete_app/have_diabetes/DashBoard/profile/recommend_screen.dart';
import 'package:mybete_app/have_diabetes/DashBoard/profile/support_feedback_screen.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        backgroundColor: Color(0xFF5FB8DD),
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          CircleAvatar(radius: 40, backgroundColor: Color(0xFF89D0ED)),
          SizedBox(height: 10),
          Text(
            "srithiba534@gmail.com",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          ListTile(
            leading: Icon(Icons.settings, color: Color(0xFF5EB7CF)),
            title: Text("Account & Settings"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AccountSettingsScreen()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.bar_chart, color: Color(0xFF5EB7CF)),
            title: Text("Stats"),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.book, color: Color(0xFF5EB7CF)),
            title: Text("User Manual"),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.share, color: Color(0xFF5EB7CF)),
            title: Text('Recommend myBete'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RecommendScreen()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.feedback, color: Color(0xFF5EB7CF)),
            title: Text("Support & Feedback"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SupportFeedbackScreen()),
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Color(0xFF5FB8DD),
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: "My Activity"),
          BottomNavigationBarItem(icon: Icon(Icons.file_copy), label: "Reports"),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: "Reminders"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}


