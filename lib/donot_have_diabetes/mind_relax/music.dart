import 'package:flutter/material.dart';

void main() {
  runApp(const music());
}

class music extends StatelessWidget {
  const music({Key? key}) : super(key: key);

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
                  _buildSoundCard('Rain', 'lib/donot_have_diabetes/mind_relax/mind images/rain.png'),
                  const SizedBox(height: 16),
                  _buildSoundCard('Forest', 'lib/donot_have_diabetes/mind_relax/mind images/forest.jpg'),
                  const SizedBox(height: 16),
                  _buildSoundCard('Ambient', 'lib/donot_have_diabetes/mind_relax/mind images/ambient.jpg'),
                  const SizedBox(height: 16),
                  _buildSoundCard('Classical', 'lib/donot_have_diabetes/mind_relax/mind images/classical.jpg'),
                  const SizedBox(height: 16),
                  _buildSoundCard('Lofi', 'lib/donot_have_diabetes/mind_relax/mind images/lofi.jpg'),
                  const SizedBox(height: 16),
                  _buildSoundCard('Meditation', 'lib/donot_have_diabetes/mind_relax/mind images/medition.jpg'),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            _buildBottomNavBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildSoundCard(String title, String imagePath) {
    return Container(
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
    );
  }

  Widget _buildBottomNavBar() {
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
          _buildNavItem(Icons.library_music, true),
          _buildNavItem(Icons.favorite, false),
          _buildNavItem(Icons.nightlight_round, false),
          _buildNavItem(Icons.person, false),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, bool isSelected) {
    return Icon(
      icon,
      size: 28,
      color: isSelected ? Colors.blue : Colors.black54,
    );
  }
}