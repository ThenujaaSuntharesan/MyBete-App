import 'package:flutter/material.dart';

class FastTestScreen extends StatefulWidget {
  @override
  _FastTestScreenState createState() => _FastTestScreenState();
}

class _FastTestScreenState extends State<FastTestScreen> {
  bool faceDroop = false;
  bool armDrift = false;
  bool speechSlurred = false;

  void checkForStroke() {
    if (faceDroop || armDrift || speechSlurred) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Stroke Warning'),
          content: Text('One or more symptoms of a stroke are present. Call emergency services immediately.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('No Stroke Symptoms Detected'),
          content: Text('No symptoms of a stroke are present.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FAST Test for Stroke'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            buildTestSection(
              context,
              'F - Face',
              'Ask the person to smile. Does one side of the face droop?',
                  (value) {
                setState(() {
                  faceDroop = value;
                });
              },
            ),
            buildTestSection(
              context,
              'A - Arms',
              'Ask the person to raise both arms. Does one drift downward?',
                  (value) {
                setState(() {
                  armDrift = value;
                });
              },
            ),
            buildTestSection(
              context,
              'S - Speech',
              'Ask the person to repeat a simple sentence. Is their speech slurred or strange?',
                  (value) {
                setState(() {
                  speechSlurred = value;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: checkForStroke,
              child: Text('Check for Stroke'),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTestSection(BuildContext context, String title, String description, Function(bool) onChanged) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(description, style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('No', style: TextStyle(fontSize: 16)),
                Switch(
                  value: title == 'F - Face' ? faceDroop : title == 'A - Arms' ? armDrift : speechSlurred,
                  onChanged: onChanged,
                ),
                Text('Yes', style: TextStyle(fontSize: 16)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
