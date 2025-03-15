import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mybete_app/donot_have_diabetes/mind_relax/mind_relax.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(const Quiz());
}

class Quiz extends StatelessWidget {
  const Quiz({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'SF Pro Display',
        scaffoldBackgroundColor: const Color(0xFFF0F4FA),
      ),
      home: const MindRelaxQuestionnairePage(),
    );
  }
}

class MindRelaxQuestionnairePage extends StatefulWidget {
  const MindRelaxQuestionnairePage({Key? key}) : super(key: key);

  @override
  State<MindRelaxQuestionnairePage> createState() =>
      _MindRelaxQuestionnairePageState();
}

class _MindRelaxQuestionnairePageState
    extends State<MindRelaxQuestionnairePage> {
  bool _isSelected = true;
  int _selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Status Bar Mockup
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            '9:41',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Row(
                            children: [
                              Icon(Icons.signal_cellular_4_bar, size: 18),
                              SizedBox(width: 4),
                              Icon(Icons.wifi, size: 18),
                              SizedBox(width: 4),
                              Icon(Icons.battery_full, size: 18),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Back Button
                    // Back Button
Padding(
  padding: const EdgeInsets.only(left: 16.0),
  child: IconButton(
    icon: const Icon(Icons.arrow_back, size: 28),
    onPressed: () {
      if (Navigator.canPop(context)) {
        Navigator.pop(context); // Go back if possible
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) =>  MindRelaxDashboard()), // Replace with actual previous screen
        );
      }
    },
    padding: EdgeInsets.zero,
    constraints: const BoxConstraints(),
  ),
),

                    const SizedBox(height: 16),

                    // Title
                    Center(
                      child: Column(
                        children: [
                          Text(
                            'Mind Relax',
                            style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              shadows: [
                                Shadow(
                                  offset: Offset(2, 2),
                                  blurRadius: 3.0,
                                  color: Colors.black.withOpacity(0.3),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            'Questionnaire',
                            style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              shadows: [
                                Shadow(
                                  offset: Offset(2, 2),
                                  blurRadius: 3.0,
                                  color: Colors.black.withOpacity(0.3),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Main Content Area with Light Blue Background
                    Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Color(0xFFD6E1F3),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(24),
                        ),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(height: 24),

                          // Zen Stones Image
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              'https://images.unsplash.com/photo-1591438252948-fa5dd3701c2a?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
                              width: 250,
                              height: 150,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(height: 80),

                          // Age Confirmation Text
                          const Text(
                            'To get started,',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text(
                            'confirm your age:',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 40),

                          // Age Option
                          InkWell(
                            onTap: () {
                              setState(() {
                                _isSelected = !_isSelected;
                              });
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 32.0),
                              child: Row(
                                children: [
                                  Container(
                                    width: 24,
                                    height: 24,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.grey.shade400,
                                        width: 2,
                                      ),
                                    ),
                                    child: _isSelected
                                        ? Center(
                                            child: Container(
                                              width: 12,
                                              height: 12,
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          )
                                        : null,
                                  ),
                                  const SizedBox(width: 16),
                                  const Text(
                                    '16 Years or Older',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 40),

                          // Get Start Button
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 32.0),
                            child: ElevatedButton(
                              onPressed: () {
                                // Navigate to next screen
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF45B3D0),
                                foregroundColor: Colors.white,
                                elevation: 4,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                minimumSize: const Size(double.infinity, 56),
                              ),
                              child: const Text(
                                'Get Start',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 40),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Bottom Navigation Bar
            Container(
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNavItem(0, Icons.book_outlined),
                  _buildNavItem(1, Icons.favorite, isActive: true),
                  _buildNavItem(2, Icons.fitness_center),
                  _buildNavItem(3, Icons.person_outline),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, {bool isActive = false}) {
    return InkWell(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Icon(
          icon,
          color:
              index == _selectedIndex ? const Color(0xFF0048FF) : Colors.black,
          size: 28,
        ),
      ),
    );
  }
}