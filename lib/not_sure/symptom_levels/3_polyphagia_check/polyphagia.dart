import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Symptom3Screen extends StatefulWidget {
  @override
  _ExtremeHungerCheckerState createState() => _ExtremeHungerCheckerState();
}

class _ExtremeHungerCheckerState extends State<Symptom3Screen> {
  int _totalCalories = 0;
  List<Map<String, dynamic>> _savedCalories = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _userId = FirebaseAuth.instance.currentUser!.uid;

  final List<Map<String, dynamic>> _foodItems = [
    {'name': 'Carbohydrates', 'calories': 300, 'image': 'lib/not_sure/symptom_levels/3_polyphagia_check/Images/Carbohydrate.jpeg'},
    {'name': 'Proteins', 'calories': 200, 'image': 'lib/not_sure/symptom_levels/3_polyphagia_check/Images/Protein.jpg'},
    {'name': 'Fats', 'calories': 200, 'image': 'lib/not_sure/symptom_levels/3_polyphagia_check/Images/Lipides.jpg'},
    {'name': 'Dairy & Alternatives', 'calories': 100, 'image': 'lib/not_sure/symptom_levels/3_polyphagia_check/Images/Dairy foods.png'},
    {'name': 'Fruits & Vegetables', 'calories': 100, 'image': 'lib/not_sure/symptom_levels/3_polyphagia_check/Images/Fruits.jpg'},
    {'name': 'Processed Foods & Beverages', 'calories': 200, 'image': 'lib/not_sure/symptom_levels/3_polyphagia_check/Images/Beverages & Processed Foods.jpg'},
  ];

  @override
  void initState() {
    super.initState();
    _loadSavedCalories();
  }

  Future<void> _loadSavedCalories() async {
    try {
      final snapshot = await _firestore
          .collection('saved_calories')
          .where('userId', isEqualTo: _userId) // Fetch data for the current user
          .orderBy('date', descending: true)
          .get();

      setState(() {
        _savedCalories = snapshot.docs.map((doc) => doc.data()).toList();
      });
    } catch (e) {
      print('Error loading saved calories: $e');
    }
  }

  Future<void> _addCalories(int calories) async {
    setState(() {
      _totalCalories += calories;
    });
  }

  Future<void> _saveCalorieCount() async {
    try {
      final today = DateTime.now().toIso8601String().substring(0, 10); // Only the date part
      final isExtreme = _totalCalories > 2000; // Extreme threshold

      final entry = {
        'userId': _userId, // Associate with the current user
        'date': today,
        'calories': _totalCalories,
        'status': isExtreme ? 'Extreme' : 'Normal',
      };

      await _firestore.collection('saved_calories').add(entry);

      setState(() {
        _savedCalories.insert(0, entry); // Add the new entry to the top of the list
        _totalCalories = 0; // Reset total calories after saving
      });
    } catch (e) {
      print('Error saving calorie count: $e');
    }
  }

  Future<void> _checkHungerReport() async {
    int extremeDays = 0;
    int healthyDays = 0;

    for (var entry in _savedCalories) {
      if (entry['status'] == 'Extreme') {
        extremeDays++;
      } else {
        healthyDays++;
      }
    }

    final result = extremeDays > healthyDays
        ? "You tend to eat extremely more often. Consider managing your diet!"
        : "Your eating habits are generally healthy. Keep it up!";

    _showDialog(
      "Hunger Report",
      "Extreme Days: $extremeDays\n"
          "Healthy Days: $healthyDays\n\n"
          "Final Outcome: $result",
    );
  }

  Future<void> _clearData() async {
    try {
      final snapshot = await _firestore
          .collection('saved_calories')
          .where('userId', isEqualTo: _userId) // Fetch entries specific to the user
          .get();

      for (var doc in snapshot.docs) {
        await _firestore.collection('saved_calories').doc(doc.id).delete();
      }

      setState(() {
        _savedCalories.clear();
        _totalCalories = 0; // Reset total calories
      });
    } catch (e) {
      print('Error clearing data: $e');
    }
  }

  void _showDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  Icon _getStatusIcon(String status) {
    if (status == 'Extreme') {
      return Icon(Icons.warning, color: Colors.red);
    } else {
      return Icon(Icons.check_circle, color: Colors.green);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Extreme Hunger Checker"),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: _saveCalorieCount,
            child: Text("Save Calorie Count"),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: _foodItems.length,
              itemBuilder: (context, index) {
                final food = _foodItems[index];
                return GestureDetector(
                  onTap: () => _addCalories(food['calories']),
                  child: Card(
                    child: Column(
                      children: [
                        Expanded(
                          child: Image.asset(
                            food['image'],
                            fit: BoxFit.cover,
                          ),
                        ),
                        Text(
                          food['name'],
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text("${food['calories']} cal"),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  "Total Calories: $_totalCalories",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _checkHungerReport,
                  child: Text("Check Hunger"),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _clearData,
                  child: Text("Clear All Data"),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _savedCalories.length,
              itemBuilder: (context, index) {
                final entry = _savedCalories[index];
                return ListTile(
                  leading: _getStatusIcon(entry['status']),
                  title: Text("Date: ${entry['date']}"),
                  subtitle: Text("Calories: ${entry['calories']}"),
                  trailing: Text(entry['status']),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
