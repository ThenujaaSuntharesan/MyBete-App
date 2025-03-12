// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// class ProfileScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Profile")),
//       body: Center(child: Text("User Profile Information")),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:mybete_app/have_diabetes/DashBoard/profile/recommend_screen.dart';
import 'package:mybete_app/have_diabetes/DashBoard/profile/support_feedback_screen.dart';


class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile")),
      body: Column(
        children: [
          SizedBox(height: 20),
          CircleAvatar(radius: 40, backgroundColor: Colors.blue),
          SizedBox(height: 10),
          Text("srithiba534@gmail.com", style: TextStyle(fontWeight: FontWeight.bold)),

          ListTile(
            leading: Icon(Icons.settings),
            title: Text("Account & Settings"),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.bar_chart),
            title: Text("Stats"),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.book),
            title: Text("User Manual"),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.share),
            title: Text('Recommend myBete'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RecommendScreen()),
              );
            },
          ),

          ListTile(
            leading: Icon(Icons.feedback),
            title: Text("Support & Feedback"),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => SupportFeedbackScreen()));
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
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
