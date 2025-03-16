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
Widget _buildIntroductionCard() {
  return Card(
    elevation: 4,
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Text(
            'Build Strength & Tone Muscles',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Develop lean muscle mass and improve muscular endurance.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
          ),
        ],
      ),
    ),
  );
}
