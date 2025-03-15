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
final List<YogaPose> _poses = [
  YogaPose(
    name: 'Mountain Pose',
    duration: '5 mins',
    benefits: 'Improves posture, reduces stress',
    icon: Icons.landscape,
  ),
  YogaPose(
    name: 'Downward Dog',
    duration: '7 mins',
    benefits: 'Strengthens arms and legs',
    icon: Icons.architecture,
  ),
  YogaPose(
    name: 'Warrior II',
    duration: '6 mins',
    benefits: 'Enhances balance and focus',
    icon: Icons.accessibility_new,
  ),
];
