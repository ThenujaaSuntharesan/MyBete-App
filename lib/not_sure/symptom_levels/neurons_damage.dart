import 'package:flutter/material.dart';

class Symptom2Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Neurons damage and stroke'),
      ),
      body: Center(
        child: Text(
          'Details and method to check Neurons damage and stroke',
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}