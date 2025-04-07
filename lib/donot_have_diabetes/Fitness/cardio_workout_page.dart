import 'package:flutter/material.dart';

class CardioWorkoutPage extends StatefulWidget {
  const CardioWorkoutPage({super.key});

  @override
  State<CardioWorkoutPage> createState() => _CardioWorkoutPageState();
}

class _CardioWorkoutPageState extends State<CardioWorkoutPage> {
  int _selectedWorkout = 0;
  final List<String> _workouts = [
    'Running',
    'Cycling',
    'Jump Rope',
    'HIIT',
    'Stair Climbing'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blueAccent,
        title: const Text(
          'Cardio Workouts',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: _showWorkoutTips,
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              _buildIntroductionCard(),
              const SizedBox(height: 32),
              _buildWorkoutTypeSelector(),
              const SizedBox(height: 32),
              _buildWorkoutInstructions(),
              const SizedBox(height: 32),
              _buildStartButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIntroductionCard() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              'Cardio Training',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Improve cardiovascular health and burn calories with our '
                  'scientifically designed programs.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWorkoutTypeSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Select Workout Type:',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _workouts.length,
            itemBuilder: (context, index) => _buildWorkoutCard(index),
          ),
        ),
      ],
    );
  }

  Widget _buildWorkoutCard(int index) {
    return GestureDetector(
      onTap: () => setState(() => _selectedWorkout = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.only(right: 16),
        width: 150,
        decoration: BoxDecoration(
          color: _selectedWorkout == index
              ? Colors.blue[50]
              : Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _selectedWorkout == index
                ? Colors.blueAccent
                : Colors.transparent,
            width: 2,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _getWorkoutIcon(_workouts[index]),
              size: 40,
              color: Colors.blueAccent,
            ),
            const SizedBox(height: 8),
            Text(
              _workouts[index],
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getWorkoutIcon(String workout) {
    switch (workout) {
      case 'Running':
        return Icons.directions_run;
      case 'Cycling':
        return Icons.directions_bike;
      case 'Jump Rope':
        return Icons.cable;
      case 'HIIT':
        return Icons.timer;
      case 'Stair Climbing':
        return Icons.accessibility;
      default:
        return Icons.fitness_center;
    }
  }

  Widget _buildWorkoutInstructions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'How to Perform:',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        _buildInstructionStep('1. Warm up for 5-10 minutes', Icons.accessibility),
        _buildInstructionStep('2. Maintain proper form throughout', Icons.assignment),
        _buildInstructionStep('3. Monitor your heart rate', Icons.favorite),
        _buildInstructionStep('4. Cool down and stretch', Icons.self_improvement),
      ],
    );
  }

  Widget _buildInstructionStep(String text, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: Colors.blueAccent),
          const SizedBox(width: 16),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }

  Widget _buildStartButton() {
    return Center(
      child: ElevatedButton.icon(
        icon: const Icon(Icons.play_arrow),
        label: const Text('Start Now'),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
        onPressed: () => _startWorkoutSession(),
      ),
    );
  }

  void _startWorkoutSession() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Workout Started'),
        content: Text('Beginning ${_workouts[_selectedWorkout]} session...'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showWorkoutTips() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cardio Tips'),
        content: const SingleChildScrollView(
          child: Column(
            children: [
              Text('• Aim for 150 minutes weekly'),
              Text('• Maintain 50-70% max heart rate'),
              Text('• Stay hydrated'),
              Text('• Wear proper footwear'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
