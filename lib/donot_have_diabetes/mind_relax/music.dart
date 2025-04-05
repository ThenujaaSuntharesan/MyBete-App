import 'package:flutter/material.dart';
import 'package:mybete_app/donot_have_diabetes/mind_relax/ambient.dart';
import 'package:mybete_app/donot_have_diabetes/mind_relax/classical.dart';
import 'package:mybete_app/donot_have_diabetes/mind_relax/forest.dart';
import 'package:mybete_app/donot_have_diabetes/mind_relax/lofi.dart';
import 'package:mybete_app/donot_have_diabetes/mind_relax/meditation.dart';


import 'package:mybete_app/donot_have_diabetes/mind_relax/rain.dart';
import 'package:mybete_app/donot_have_diabetes/meal_plans/meal.dart';
import 'package:mybete_app/donot_have_diabetes/Fitness/exercise.dart';
import 'package:mybete_app/donot_have_diabetes/mind_relax/mind_relax.dart';

void main() {
  runApp(const Music());
}

class Music extends StatelessWidget {

  const Music({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const RelaxApp(),
    );
  }
}



class RelaxApp extends StatelessWidget {
  const RelaxApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    'Relax Your Mind',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  _buildSoundCard(context, 'Rain',
                      'lib/donot_have_diabetes/mind_relax/mind images/rain.png'),
                  const SizedBox(height: 16),
                  _buildSoundCard(context, 'Forest',
                      'lib/donot_have_diabetes/mind_relax/mind images/forest.jpg'),
                  const SizedBox(height: 16),
                  _buildSoundCard(context, 'Ambient',
                      'lib/donot_have_diabetes/mind_relax/mind images/ambient.jpg'),
                  const SizedBox(height: 16),
                  _buildSoundCard(context, 'Classical',
                      'lib/donot_have_diabetes/mind_relax/mind images/classical.jpg'),
                  const SizedBox(height: 16),
                  _buildSoundCard(context, 'Lofi',
                      'lib/donot_have_diabetes/mind_relax/mind images/lofi.jpg'),
                  const SizedBox(height: 16),
                  _buildSoundCard(context, 'Meditation',
                      'lib/donot_have_diabetes/mind_relax/mind images/medition.jpg'),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            
          ],
        ),
      ),
    );
  }

  Widget _buildSoundCard(BuildContext context, String title, String imagePath) {
    return GestureDetector(
      onTap: () {
        // Navigate to the corresponding screen based on the title
        switch (title) {
          case 'Rain':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const RainScreen()),
            );
            break;
          case 'Forest':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ForestScreen()),
            );
            break;
          case 'Ambient':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AmbientScreen()),
            );
            break;
          case 'Classical':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ClassicalScreen()),
            );
            break;
          case 'Lofi':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LofiScreen()),
            );
            break;
          case 'Meditation':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MeditationScreen()),
            );
            break;
        }
      },
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            // Gradient overlay for better text visibility
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Colors.black.withOpacity(0.4),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
            // Text
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

 Widget buildSoundCard(BuildContext context, String title, Widget screen) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => screen),
        );
      },
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.blueAccent.withOpacity(0.2),
        ),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildBottomNavBar(BuildContext context) {
    return Container(
      height: 60,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: Colors.black12,
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNavItem(context, Icons.fastfood, const MealPlannerScreen()),
          _buildNavItem(context, Icons.favorite, const MindRelaxDashboard()),
          _buildNavItem(context, Icons.fitness_center, const Exercise()),
          //_buildNavItem(context, Icons.person_outline, const Profile())
          
        ],
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, IconData icon, Widget screen) {
    return IconButton(
      icon: Icon(icon, size: 28, color: Colors.black54),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => screen),
        );
      },
    );
  }
}
