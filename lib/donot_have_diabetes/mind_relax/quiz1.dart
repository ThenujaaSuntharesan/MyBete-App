import 'package:flutter/material.dart';
import 'package:mybete_app/donot_have_diabetes/mind_relax/Quiz.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: const Color(0xFFC5EDFF),
      ),
      home: const MoodCheckScreen(),
    );
  }
}

class MoodCheckScreen extends StatefulWidget {
  const MoodCheckScreen({Key? key}) : super(key: key);

  @override
  State<MoodCheckScreen> createState() => _MoodCheckScreenState();
}

class _MoodCheckScreenState extends State<MoodCheckScreen> {
  String? selectedMood;
  String? selectedStressLevel;
  String? selectedGratitude;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    // Header with Back & Skip Button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon:
                              const Icon(Icons.arrow_back, color: Colors.black),
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Quiz()),
                            );
                          },
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF5EB7CF),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 12),
                          ),
                          child: const Text('Skip',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Title
                    const Padding(
                      padding: EdgeInsets.only(left: 16.0),
                      child: Text(
                        'Mood & Well-being Check',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Question 1
                    QuestionCard(
                      question: '1. How are you feeling today?',
                      options: [
                        MoodOption(emoji: '😄', label: 'Happy', value: 'happy'),
                        MoodOption(
                            emoji: '😐', label: 'Stressed', value: 'stressed'),
                        MoodOption(
                            emoji: '😠', label: 'Anxious', value: 'anxious'),
                        MoodOption(emoji: '😌', label: 'Calm', value: 'calm'),
                      ],
                      selectedValue: selectedMood,
                      onSelected: (value) {
                        setState(() {
                          selectedMood = value;
                        });
                      },
                    ),
                    const SizedBox(height: 24),
                    // Question 2
                    QuestionCard(
                      question: '2. What\'s your stress level right now?',
                      options: [
                        TextOption(label: 'Low', value: 'low'),
                        TextOption(label: 'Medium', value: 'medium'),
                        TextOption(label: 'High', value: 'high'),
                      ],
                      selectedValue: selectedStressLevel,
                      onSelected: (value) {
                        setState(() {
                          selectedStressLevel = value;
                        });
                      },
                    ),
                    const SizedBox(height: 24),
                    // Question 3
                    QuestionCard(
                      question:
                          '3. What\'s one thing you\'re grateful for today?',
                      options: [
                        TextOption(label: 'Family', value: 'family'),
                        TextOption(label: 'Health', value: 'health'),
                        TextOption(label: 'Friends', value: 'friends'),
                        TextOption(label: 'Work', value: 'work'),
                      ],
                      selectedValue: selectedGratitude,
                      onSelected: (value) {
                        setState(() {
                          selectedGratitude = value;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
            // Fixed Next Button
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF5EB7CF),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text(
                    'Next',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --------------------------- Question Card ----------------------------
class QuestionCard extends StatelessWidget {
  final String question;
  final List<Option> options;
  final String? selectedValue;
  final Function(String) onSelected;

  const QuestionCard({
    Key? key,
    required this.question,
    required this.options,
    required this.selectedValue,
    required this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white
            .withOpacity(0.8), // Adjust opacity for better visibility
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            question,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 16),
          ...options.map((option) => Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: OptionTile(
                  option: option,
                  isSelected: selectedValue == option.value,
                  onTap: () => onSelected(option.value),
                ),
              )),
        ],
      ),
    );
  }
}

// --------------------------- Option Types ----------------------------
abstract class Option {
  final String label;
  final String value;

  Option({required this.label, required this.value});

  Widget buildLeading();
}

class MoodOption extends Option {
  final String emoji;

  MoodOption(
      {required this.emoji, required String label, required String value})
      : super(label: label, value: value);

  @override
  Widget buildLeading() {
    return Text(
      emoji,
      style: const TextStyle(fontSize: 24),
    );
  }
}

class TextOption extends Option {
  TextOption({required String label, required String value})
      : super(label: label, value: value);

  @override
  Widget buildLeading() {
    return const SizedBox.shrink();
  }
}

// --------------------------- Option Tile ----------------------------
class OptionTile extends StatelessWidget {
  final Option option;
  final bool isSelected;
  final VoidCallback onTap;

  const OptionTile({
    Key? key,
    required this.option,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Radio(
            value: true,
            groupValue: isSelected,
            onChanged: (_) => onTap(),
            activeColor: const Color(0xFF5EB7CF),
          ),
          if (option is MoodOption) ...[
            option.buildLeading(),
            const SizedBox(width: 12),
          ],
          Text(
            option.label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
