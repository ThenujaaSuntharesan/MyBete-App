import 'package:flutter/material.dart';

class NotSureDashboard extends StatelessWidget {
  final List<String> symptoms = [
    'Feeling Extra Thirsty (Polydipsia)',
    'Neurons damage and stroke',
    'Extreme Hunger (Polyphagia)',
    'Weight changes',
    'Frequent urinary tract infections or yeast infections (Polyuria)',
    'Blurry vision',
    'Feeling more tired than usual',
    'Skin changes',
    'Numbness or tingling in the feet',
    'Changes to your periods',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Diabetes Dashboard"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back), // Back arrow icon
          onPressed: () {
            Navigator.pop(context); // Navigate back to the previous screen
          },
        ),
      ),
      body: ListView.builder(
        itemCount: symptoms.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              child: Text('${index + 1}'),
            ),
            title: Text(symptoms[index]),
            onTap: () {
              // Navigate to the level details screen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LevelDetailScreen(level: index + 1, symptom: symptoms[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class LevelDetailScreen extends StatelessWidget {
  final int level;
  final String symptom;

  LevelDetailScreen({required this.level, required this.symptom});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Level $level'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Level $level: $symptom',
              style: TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to the method or game page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MethodOrGameScreen(level: level, symptom: symptom),
                  ),
                );
              },
              child: Text('Check Symptom'),
            ),
          ],
        ),
      ),
    );
  }
}

class MethodOrGameScreen extends StatelessWidget {
  final int level;
  final String symptom;

  MethodOrGameScreen({required this.level, required this.symptom});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Method or Game for Level $level'),
      ),
      body: Center(
        child: Text(
          'Here you can implement the method or game to check the symptom: $symptom',
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}