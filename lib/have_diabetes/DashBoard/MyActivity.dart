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
        selectedItemColor: Color(0xFF5FB8DD),
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

class MyActivityScreen extends StatefulWidget {
  @override
  _MyActivityScreenState createState() => _MyActivityScreenState();
}

class _MyActivityScreenState extends State<MyActivityScreen> {
  List<Map<String, String>> logs = [];

  void _addLog(Map<String, String> newLog) {
    setState(() {
      logs.insert(0, newLog);
    });
  }

  void _openLogEntryDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return LogEntryDialog(onSave: _addLog);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Activity"),
        backgroundColor: Color(0xFF5FB8DD),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Stats Graph
            Expanded(
              child: logs.isEmpty
                  ? Center(child: Text("No logs available. Add your first entry!"))
                  : LineChart(
                LineChartData(
                  gridData: FlGridData(show: true),
                  titlesData: FlTitlesData(show: true),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: logs
                          .asMap()
                          .entries
                          .map((entry) => FlSpot(
                          entry.key.toDouble(),
                          double.tryParse(entry.value["bloodSugar"] ?? "0") ?? 0))
                          .toList(),
                      isCurved: true,
                      color: Color(0xFF5EB7CF),
                      barWidth: 4,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            // Log History
            Expanded(
              child: ListView.builder(
                itemCount: logs.length,
                itemBuilder: (context, index) {
                  final log = logs[index];
                  return ListTile(
                    title: Text("${log['date']} at ${log['time']}"),
                    subtitle: Text("Blood Sugar: ${log['bloodSugar']} mg/dL"),
                    leading: Icon(Icons.history, color: Color(0xFF5FB8DD)),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF5FB8DD),
        onPressed: _openLogEntryDialog,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

class LogEntryDialog extends StatefulWidget {
  final Function(Map<String, String>) onSave;

  LogEntryDialog({required this.onSave});

  @override
  _LogEntryDialogState createState() => _LogEntryDialogState();
}

class _LogEntryDialogState extends State<LogEntryDialog> {
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController bloodSugarController = TextEditingController();

  Future<void> _selectDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      setState(() {
        dateController.text = "${pickedDate.toLocal()}".split(' ')[0];
      });
    }
  }

  Future<void> _selectTime() async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      setState(() {
        timeController.text = pickedTime.format(context);
      });
    }
  }

  void _saveLog() {
    if (dateController.text.isEmpty ||
        timeController.text.isEmpty ||
        bloodSugarController.text.isEmpty) {
      return;
    }

    widget.onSave({
      "date": dateController.text,
      "time": timeController.text,
      "bloodSugar": bloodSugarController.text,
    });

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Add Log"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: dateController,
            decoration: InputDecoration(labelText: "Date"),
            readOnly: true,
            onTap: _selectDate,
          ),
          TextField(
            controller: timeController,
            decoration: InputDecoration(labelText: "Time"),
            readOnly: true,
            onTap: _selectTime,
          ),
          TextField(
            controller: bloodSugarController,
            decoration: InputDecoration(labelText: "Blood Sugar (mg/dL)"),
            keyboardType: TextInputType.number,
          ),
        ],
      ),
      actions: [
        TextButton(onPressed: () => Navigator.of(context).pop(), child: Text("Cancel")),
        ElevatedButton(onPressed: _saveLog, child: Text("Save")),
      ],
    );
  }
}