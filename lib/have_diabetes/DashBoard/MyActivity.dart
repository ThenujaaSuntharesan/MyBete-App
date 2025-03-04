//
//
// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
//
// class DashboardScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFFC5EDFF),
//       appBar: AppBar(
//         title: Text("My Activity"),
//         backgroundColor: Color(0xFF5FB8DD),
//       ),
//       body: Column(
//         children: [
//           // Stats section at the top
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Container(
//               height: 200,
//               decoration: BoxDecoration(
//                 color: Color(0xFF89D0ED),
//                 borderRadius: BorderRadius.circular(20),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black12,
//                     blurRadius: 5,
//                     spreadRadius: 2,
//                   )
//                 ],
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: LineChart(
//                   LineChartData(
//                     gridData: FlGridData(show: false),
//                     titlesData: FlTitlesData(show: false),
//                     borderData: FlBorderData(show: false),
//                     lineBarsData: [
//                       LineChartBarData(
//                         spots: [
//                           FlSpot(0, 100),
//                           FlSpot(1, 120),
//                           FlSpot(2, 150),
//                           FlSpot(3, 130),
//                           FlSpot(4, 170),
//                           FlSpot(5, 160),
//                         ],
//                         isCurved: true,
//                         gradient: LinearGradient(
//                           colors: [Color(0xFF5FB8DD), Color(0xFF5EB7CF)],
//                         ),
//                         belowBarData: BarAreaData(show: false),
//                         dotData: FlDotData(show: true),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//
//           // Rest of the dashboard (Placeholder for now)
//           Expanded(
//             child: Container(
//               padding: EdgeInsets.all(16),
//               child: Center(
//                 child: Text("Dashboard Content Here", style: TextStyle(fontSize: 18)),
//               ),
//             ),
//           ),
//         ],
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         selectedItemColor: Color(0xFF5FB8DD),
//         unselectedItemColor: Colors.grey,
//         items: [
//           BottomNavigationBarItem(icon: Icon(Icons.home), label: "My Activity"),
//           BottomNavigationBarItem(icon: Icon(Icons.analytics), label: "Reports"),
//           BottomNavigationBarItem(icon: Icon(Icons.notifications), label: "Reminders"),
//           BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
//         ],
//       ),
//     );
//   }
// }
//
//
// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';
//
// import 'Profile.dart';
// import 'Reminders.dart';
// import 'Reports.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: DashboardScreen(),
//     );
//   }
// }
//
// class DashboardScreen extends StatefulWidget {
//   @override
//   _DashboardScreenState createState() => _DashboardScreenState();
// }
//
// class _DashboardScreenState extends State<DashboardScreen> {
//   int _selectedIndex = 0;
//   final List<Widget> _screens = [
//     MyActivityScreen(),
//     ReportsScreen(),
//     RemindersScreen(),
//     ProfileScreen(),
//   ];
//
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _screens[_selectedIndex],
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _selectedIndex,
//         onTap: _onItemTapped,
//         selectedItemColor: Colors.blueAccent,
//         unselectedItemColor: Colors.grey,
//         items: [
//           BottomNavigationBarItem(icon: Icon(Icons.home), label: "My Activity"),
//           BottomNavigationBarItem(icon: Icon(Icons.analytics), label: "Reports"),
//           BottomNavigationBarItem(icon: Icon(Icons.alarm), label: "Reminders"),
//           BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
//         ],
//       ),
//     );
//   }
// }
//
// class MyActivityScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("My Activity")),
//       body: Column(
//         children: [
//           Container(
//             height: 200,
//             padding: EdgeInsets.all(16),
//             child: LineChart(
//               LineChartData(
//                 gridData: FlGridData(show: false),
//                 titlesData: FlTitlesData(show: false),
//                 borderData: FlBorderData(show: false),
//                 lineBarsData: [
//                   LineChartBarData(
//                     spots: [
//                       FlSpot(0, 1),
//                       FlSpot(1, 3),
//                       FlSpot(2, 2),
//                       FlSpot(3, 5),
//                       FlSpot(4, 3),
//                       FlSpot(5, 4),
//                     ],
//                     isCurved: true,
//                     gradient: LinearGradient(
//                       colors: [Colors.blue, Colors.lightBlueAccent], // Replace `colors` with `gradient`
//                     ),
//                     barWidth: 4,
//                     belowBarData: BarAreaData(show: false),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Expanded(
//             child: Center(child: Text("Activity Content Here")),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
//
//
//

//
// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';
//
// import 'Profile.dart';
// import 'Reminders.dart';
// import 'Reports.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: DashboardScreen(),
//     );
//   }
// }
//
// class DashboardScreen extends StatefulWidget {
//   @override
//   _DashboardScreenState createState() => _DashboardScreenState();
// }
//
// class _DashboardScreenState extends State<DashboardScreen> {
//   int _selectedIndex = 0;
//   final List<Widget> _screens = [
//     MyActivityScreen(),
//     ReportsScreen(),
//     RemindersScreen(),
//     ProfileScreen(),
//   ];
//
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _screens[_selectedIndex],
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _selectedIndex,
//         onTap: _onItemTapped,
//         selectedItemColor: Colors.blueAccent,
//         unselectedItemColor: Colors.grey,
//         items: [
//           BottomNavigationBarItem(icon: Icon(Icons.home), label: "My Activity"),
//           BottomNavigationBarItem(icon: Icon(Icons.analytics), label: "Reports"),
//           BottomNavigationBarItem(icon: Icon(Icons.alarm), label: "Reminders"),
//           BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
//         ],
//       ),
//     );
//   }
// }
//
// class MyActivityScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("My Activity")),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Card(
//               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//               elevation: 5,
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text("Activity Overview", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//                     SizedBox(height: 10),
//                     Container(
//                       height: 200,
//                       child: LineChart(
//                         LineChartData(
//                           gridData: FlGridData(show: false),
//                           titlesData: FlTitlesData(show: false),
//                           borderData: FlBorderData(show: false),
//                           lineBarsData: [
//                             LineChartBarData(
//                               spots: [
//                                 FlSpot(0, 1),
//                                 FlSpot(1, 3),
//                                 FlSpot(2, 2),
//                                 FlSpot(3, 5),
//                                 FlSpot(4, 3),
//                                 FlSpot(5, 4),
//                               ],
//                               isCurved: true,
//                               gradient: LinearGradient(
//                                 colors: [Colors.blue, Colors.lightBlueAccent], // Replace `colors` with `gradient`
//                               ),
//                               barWidth: 4,
//                               belowBarData: BarAreaData(show: false),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             SizedBox(height: 20),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 _activityCard("Steps", "10,200", Icons.directions_walk, Colors.orange),
//                 _activityCard("Calories", "250 kcal", Icons.local_fire_department, Colors.red),
//                 _activityCard("Active Time", "2h 30m", Icons.timer, Colors.blue),
//               ],
//             ),
//             SizedBox(height: 20),
//             Expanded(
//               child: ListView(
//                 children: [
//                   _activityListTile("Morning Walk", "07:00 AM - 07:30 AM", Icons.directions_walk, Colors.green),
//                   _activityListTile("Gym Workout", "10:00 AM - 11:00 AM", Icons.fitness_center, Colors.blueAccent),
//                   _activityListTile("Cycling", "05:00 PM - 06:00 PM", Icons.directions_bike, Colors.purple),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _activityCard(String title, String value, IconData icon, Color color) {
//     return Card(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//       elevation: 3,
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             Icon(icon, size: 30, color: color),
//             SizedBox(height: 5),
//             Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//             Text(value, style: TextStyle(fontSize: 14, color: Colors.grey[700])),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _activityListTile(String title, String subtitle, IconData icon, Color color) {
//     return ListTile(
//       leading: Icon(icon, color: color),
//       title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
//       subtitle: Text(subtitle, style: TextStyle(color: Colors.grey[600])),
//       trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import 'Profile.dart';
import 'Reminders.dart';
import 'Reports.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;
  final List<Widget> _screens = [
    MyActivityScreen(),
    ReportsScreen(),
    RemindersScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "My Activity"),
          BottomNavigationBarItem(icon: Icon(Icons.analytics), label: "Reports"),
          BottomNavigationBarItem(icon: Icon(Icons.alarm), label: "Reminders"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}

class MyActivityScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My Activity")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Activity Overview", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    Container(
                      height: 200,
                      child: LineChart(
                        LineChartData(
                          gridData: FlGridData(show: false),
                          titlesData: FlTitlesData(show: false),
                          borderData: FlBorderData(show: false),
                          lineBarsData: [
                            LineChartBarData(
                              spots: [
                                FlSpot(0, 1),
                                FlSpot(1, 3),
                                FlSpot(2, 2),
                                FlSpot(3, 5),
                                FlSpot(4, 3),
                                FlSpot(5, 4),
                              ],
                              isCurved: true,
                              gradient: LinearGradient(
                                colors: [Colors.blue, Colors.lightBlueAccent], // Replace `colors` with `gradient`
                              ),
                              barWidth: 4,
                              belowBarData: BarAreaData(show: false),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _activityCard("Steps", "-", Icons.directions_walk, Colors.orange),
                _activityCard("Average mg/dL", "-", Icons.local_fire_department, Colors.red),
                _activityCard("Active Time", "-", Icons.timer, Colors.blue),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  _activityListTile("Monday 17 Feb 2025", "07:00 AM - 07:30 AM", Icons.local_fire_department, Colors.green),
                  _activityListTile("Monday 17 Feb 2025", "07:00 AM - 07:30 AM", Icons.local_fire_department, Colors.green),
                  _activityListTile("Monday 17 Feb 2025", "07:00 AM - 07:30 AM", Icons.local_fire_department, Colors.green),

                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Implement logging functionality here
        },
        child: Icon(Icons.note_add),
        backgroundColor: Colors.blueAccent,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget _activityCard(String title, String value, IconData icon, Color color) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Icon(icon, size: 30, color: color),
            SizedBox(height: 5),
            Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text(value, style: TextStyle(fontSize: 14, color: Colors.grey[700])),
          ],
        ),
      ),
    );
  }

  Widget _activityListTile(String title, String subtitle, IconData icon, Color color) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle, style: TextStyle(color: Colors.grey[600])),
      trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
    );
  }
}