import 'package:flutter/material.dart';

class StrengthToningPage extends StatefulWidget {
  const StrengthToningPage({super.key});

  @override
  State<StrengthToningPage> createState() => _StrengthToningPageState();
}

class _StrengthToningPageState extends State<StrengthToningPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Strength & Toning')),
      body: const Center(child: Text('Strength Training Page')),
    );
  }
}
