import 'package:flutter/material.dart';
import 'Fitness/exercise.dart';
// import 'meal_planner_dashboard.dart';
// import 'mind_relax_dashboard.dart';

class DonotHaveDiabeteDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set background color to white
      appBar: AppBar(
        title: Text("I Do Not Have Diabetes"),
        centerTitle: false,
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.code),
            onPressed: () {
              // Add action here
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min, // Center content vertically
          children: [
            // DashboardButton(title: "Meal Planner", page: MealPlannerDashboard()),
            SizedBox(height: 20),
            // DashboardButton(title: "Mind Relax", page: MindRelaxDashboard()),
            SizedBox(height: 20),
            DashboardButton(title: "Fitness", page: Exercise()),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        currentIndex: 1, // Default selected index
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: "Dashboard"),
          BottomNavigationBarItem(icon: Icon(Icons.receipt), label: "Reports"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}

class DashboardButton extends StatelessWidget {
  final String title;
  final Widget page;

  const DashboardButton({required this.title, required this.page});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250, // Set equal width for all buttons
      height: 50, // Set equal height for all buttons
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey[300],
          foregroundColor: Colors.black,
          textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => page),
          );
        },
        child: Text(title),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: DonotHaveDiabeteDashboard(),
  ));
}
