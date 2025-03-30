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
          .where('userId', isEqualTo: _userId)
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
      final today = DateTime.now().toIso8601String().substring(0, 10);
      final isExtreme = _totalCalories > 2000;

      final entry = {
        'userId': _userId,
        'date': today,
        'calories': _totalCalories,
        'status': isExtreme ? 'Extreme' : 'Normal',
      };

      await _firestore.collection('saved_calories').add(entry);

      setState(() {
        _savedCalories.insert(0, entry);
        _totalCalories = 0;
      });

      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Calorie count saved successfully!'),
            backgroundColor: Colors.green,
          )
      );
    } catch (e) {
      print('Error saving calorie count: $e');
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to save data'),
            backgroundColor: Colors.red,
          )
      );
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
      extremeDays > healthyDays ? Colors.orange : Colors.green,
    );
  }

  Future<void> _clearData() async {
    try {
      final snapshot = await _firestore
          .collection('saved_calories')
          .where('userId', isEqualTo: _userId)
          .get();

      for (var doc in snapshot.docs) {
        await _firestore.collection('saved_calories').doc(doc.id).delete();
      }

      setState(() {
        _savedCalories.clear();
        _totalCalories = 0;
      });

      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('All data cleared successfully!'),
            backgroundColor: Colors.green,
          )
      );
    } catch (e) {
      print('Error clearing data: $e');
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to clear data'),
            backgroundColor: Colors.red,
          )
      );
    }
  }

  void _showDialog(String title, String message, Color color) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Color(0xFFF8F9FA),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
        ),
        content: Text(
          message,
          style: TextStyle(fontSize: 16),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'OK',
              style: TextStyle(color: color),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getStatusIcon(String status) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: status == 'Extreme' ? Colors.red[100] : Colors.green[100],
        shape: BoxShape.circle,
      ),
      child: Icon(
        status == 'Extreme' ? Icons.warning : Icons.check_circle,
        color: status == 'Extreme' ? Colors.red : Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Extreme Hunger Checker",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF288994),
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        color: Color(0xFFE6F7FF),
        child: Column(
          children: [
            // Food Selection Grid
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    childAspectRatio: 0.9,
                  ),
                  itemCount: _foodItems.length,
                  itemBuilder: (context, index) {
                    final food = _foodItems[index];
                    return Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(15),
                        onTap: () => _addCalories(food['calories']),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(15),
                                ),
                                child: Image.asset(
                                  food['image'],
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text(
                                    food['name'],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    "${food['calories']} calories",
                                    style: TextStyle(
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            // Total Calories and Actions
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, -5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                    decoration: BoxDecoration(
                      color: _totalCalories > 2000 ? Colors.red[100] : Colors.green[100],
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text(
                      "Total Calories: $_totalCalories",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: _totalCalories > 2000 ? Colors.red[800] : Colors.green[800],
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton.icon(
                        icon: Icon(Icons.save, size: 20),
                        label: Text("Save"),
                        onPressed: _saveCalorieCount,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF35B4C9),
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                      ElevatedButton.icon(
                        icon: Icon(Icons.analytics, size: 20),
                        label: Text("Report"),
                        onPressed: _checkHungerReport,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF96D8E3),
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                      ElevatedButton.icon(
                        icon: Icon(Icons.delete, size: 20),
                        label: Text("Clear"),
                        onPressed: _clearData,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFE28869),
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Saved Calories List
            if (_savedCalories.isNotEmpty)
              Expanded(
                flex: 3,
                child: Container(
                  padding: EdgeInsets.only(top: 16),
                  child: Column(
                    children: [
                      Text(
                        "Your History",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF06333B),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          padding: EdgeInsets.only(top: 8),
                          itemCount: _savedCalories.length,
                          itemBuilder: (context, index) {
                            final entry = _savedCalories[index];
                            return Card(
                              margin: EdgeInsets.symmetric(
                                vertical: 4,
                                horizontal: 16,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ListTile(
                                leading: _getStatusIcon(entry['status']),
                                title: Text(
                                  entry['date'],
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(
                                  "${entry['calories']} calories",
                                  style: TextStyle(color: Colors.grey[700]),
                                ),
                                trailing: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: entry['status'] == 'Extreme'
                                        ? Colors.red[50]
                                        : Colors.green[50],
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    entry['status'],
                                    style: TextStyle(
                                      color: entry['status'] == 'Extreme'
                                          ? Colors.red
                                          : Colors.green,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}