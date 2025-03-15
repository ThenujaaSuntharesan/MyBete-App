import 'package:flutter/material.dart';

class YogaSessionPage extends StatefulWidget {
  const YogaSessionPage({super.key});

  @override
  State<YogaSessionPage> createState() => _YogaSessionPageState();
}

class _YogaSessionPageState extends State<YogaSessionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Yoga Session')),
      body: const Center(child: Text('Yoga Session Page')),
    );
  }
}
class YogaPose {
  final String name;
  final String duration;
  final String benefits;
  final IconData icon;

  YogaPose({
    required this.name,
    required this.duration,
    required this.benefits,
    required this.icon,
  });
}
