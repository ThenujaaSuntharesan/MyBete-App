import 'dart:math';
import 'package:flutter/material.dart';

class Symptom6Screen extends StatefulWidget {
  @override
  _BlurryVisionTestState createState() => _BlurryVisionTestState();
}

class _BlurryVisionTestState extends State<Symptom6Screen> {
  final List<String> directions = ['up', 'down', 'left', 'right'];
  final List<String> userResponses = [];
  final List<String> correctAnswers = [];
  final Random random = Random();
  String currentDirection = '';
  int testCount = 0;

  @override
  void initState() {
    super.initState();
    generateNextE();
  }

  void generateNextE() {
    if (testCount < 10) {
      // Randomly pick a direction
      currentDirection = directions[random.nextInt(directions.length)];
      // Save correct answer
      correctAnswers.add(currentDirection);
      testCount++;
      setState(() {});
    } else {
      // Generate and save report after 10 tests
      generateReport();
    }
  }

  void handleUserInput(String direction) {
    // Record user input
    userResponses.add(direction);
    // Move to next E
    generateNextE();
  }

  void generateReport() {
    DateTime now = DateTime.now();
    int correctCount = 0;

    for (int i = 0; i < correctAnswers.length; i++) {
      if (userResponses[i] == correctAnswers[i]) {
        correctCount++;
      }
    }

    String report = '''
      Vision Test Report
      Date: ${now.toLocal()}
      Correct Answers: $correctCount / ${correctAnswers.length}
      Result: ${correctCount >= 8 ? 'Vision not blurry' : 'Possible blurry vision detected'}
    ''';

    // Print the report or save it to a file/database
    print(report);

    // Show report in a dialog
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Test Report'),
          content: Text(report),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Reset test
                resetTest();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void resetTest() {
    testCount = 0;
    userResponses.clear();
    correctAnswers.clear();
    generateNextE();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blurry Vision Checker'),
      ),
      body: testCount <= 10
          ? Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Which direction is the "E" facing?',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 20),
          RotatedBox(
            quarterTurns: currentDirection == 'up'
                ? 0
                : currentDirection == 'right'
                ? 1
                : currentDirection == 'down'
                ? 2
                : 3,
            child: Text(
              'E',
              style: TextStyle(fontSize: 100),
            ),
          ),
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () => handleUserInput('up'),
                child: Text('↑'),
              ),
              ElevatedButton(
                onPressed: () => handleUserInput('left'),
                child: Text('←'),
              ),
              ElevatedButton(
                onPressed: () => handleUserInput('down'),
                child: Text('↓'),
              ),
              ElevatedButton(
                onPressed: () => handleUserInput('right'),
                child: Text('→'),
              ),
            ],
          ),
        ],
      )
          : Center(child: Text('Test Completed')),
    );
  }
}
