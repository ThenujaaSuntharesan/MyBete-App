import 'package:flutter/material.dart';

class ExerciseDashboard extends StatelessWidget {
  final List<ExerciseCategory> categories = [
    ExerciseCategory(
      title: 'Step Counter',
      icon: Icons.directions_walk,
      type: ExerciseType.steps,
    ),
    ExerciseCategory(
      title: 'Cardio Workout',
      icon: Icons.directions_run,
      type: ExerciseType.cardio,
    ),
    ExerciseCategory(
      title: 'Yoga Session',
      icon: Icons.self_improvement,
      type: ExerciseType.yoga,
    ),
    ExerciseCategory(
      title: 'Strength Training',
      icon: Icons.fitness_center,
      type: ExerciseType.strength,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fitness Program'),
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1.2,
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) => ExerciseCategoryCard(
          category: categories[index],
          onTap: () => _navigateToExercise(context, categories[index]),
        ),
      ),
    );
  }

  void _navigateToExercise(BuildContext context, ExerciseCategory category) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ExerciseDetailScreen(category: category),
      ),
    );
  }
}

class ExerciseCategory {
  final String title;
  final IconData icon;
  final ExerciseType type;

  ExerciseCategory({
    required this.title,
    required this.icon,
    required this.type,
  });
}

enum ExerciseType { steps, cardio, yoga, strength }

class ExerciseCategoryCard extends StatelessWidget {
  final ExerciseCategory category;
  final VoidCallback onTap;

  const ExerciseCategoryCard({
    required this.category,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(category.icon, size: 48, color: Colors.blue),
            SizedBox(height: 16),
            Text(
              category.title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

class ExerciseDetailScreen extends StatelessWidget {
  final ExerciseCategory category;

  const ExerciseDetailScreen({required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(category.icon, size: 64, color: Colors.blue),
            SizedBox(height: 24),
            Text(
              'Start Your ${category.title}',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () => _startExercise(context),
              child: Text('Begin Session'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _startExercise(BuildContext context) {
    // Add specific exercise tracking logic here
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Exercise Started'),
        content: Text('Tracking your ${category.title}...'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
          ),
        ],
      ),
    );
  }
}