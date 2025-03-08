import 'package:flutter/material.dart';

void main() {
  runApp(MindRelaxDashboard());
}

class MindRelaxDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Dashboard'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Reports'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        currentIndex: 1, // Dashboard is selected
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Mind Relax',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: ListView(
                  children: [
                    _buildCard(
                      title: 'Mental Health Questionnaire',
                      description:
                          'Regular mental health check-ins help you stay proactive, identify risks, and maintain balance in daily life.',
                      buttonText: 'Take Questionnaire',
                      gradientColors: [Colors.blueAccent, Colors.cyan],
                    ),
                    _buildCard(
                      title: 'Sleep',
                      description:
                          'Quality sleep is essential for mental and physical well-being. Prioritize rest to improve mood, focus, and overall health.',
                      buttonText: 'Get Start',
                      gradientColors: [Colors.purpleAccent, Colors.pinkAccent],
                    ),
                    _buildCard(
                      title: 'Meditate and relax music',
                      description:
                          'Meditation and relaxing music can help reduce stress, improve focus, and promote a sense of calm for better well-being.',
                      buttonText: 'Get Start',
                      gradientColors: [Colors.pinkAccent, Colors.blueAccent],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard({
    required String title,
    required String description,
    required String buttonText,
    required List<Color> gradientColors,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8),
            Text(
              description,
              style: TextStyle(
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.blue,
              ),
              child: Text(buttonText),
            ),
          ],
        ),
      ),
    );
  }
}