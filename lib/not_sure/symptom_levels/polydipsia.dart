import 'package:flutter/material.dart';

class Symptom1Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feeling Extra Thirsty (Polydipsia)'),
      ),
      body: Center(
        child: Text(
          'Details and method to check Feeling Extra Thirsty (Polydipsia)',
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}