import 'package:flutter/material.dart';
import 'package:mybete_app/donot_have_diabetes/Fitness/exercise_dashboard.dart';

void main() {
  runApp(const Exercise());
}
class Exercise extends StatelessWidget {
  const Exercise({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fitness Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ExerciseDashboard(),
    );
  }
}

