import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TotalScreen extends StatefulWidget {
  final String category;
  const TotalScreen({Key? key, required this.category}) : super(key: key);

  @override
  _TotalScreenState createState() => _TotalScreenState();
}

class _TotalScreenState extends State<TotalScreen> {
  List<Map<String, dynamic>> clickedItems = [];
  num totalCalories = 0;

  void _fetchClickedItems() async {
    final userId = 'user123'; // Replace with the actual user ID
    final userRef = FirebaseFirestore.instance.collection('users').doc(userId);

    final querySnapshot = await userRef.collection(widget.category).get();

    num caloriesSum = 0;
    List<Map<String, dynamic>> items = [];
    for (var doc in querySnapshot.docs) {
      final data = doc.data();
      final name = data['name'];
      final calories = data['calories'];

      items.add({'name': name, 'calories': calories});

      if (calories is num) {
        caloriesSum += calories;
      }
    }

    setState(() {
      clickedItems = items;
      totalCalories = caloriesSum;
    });
  }

  void _addCalorieToFirebase(String name, num calories) async {
    final userId = 'user123'; // Replace with the actual user ID
    final userRef = FirebaseFirestore.instance.collection('users').doc(userId);

    await userRef.collection(widget.category).add({
      'name': name,
      'calories': calories,
    });

    _fetchClickedItems();  // Re-fetch the items after adding a new one
  }

  @override
  void initState() {
    super.initState();
    _fetchClickedItems(); // Fetch clicked items when the screen loads
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.category} - Total Calories'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: clickedItems.length,
                itemBuilder: (context, index) {
                  final item = clickedItems[index];
                  return ListTile(
                    title: Text(item['name']),
                    trailing: Text('${item['calories']} kcal'),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                decoration: BoxDecoration(
                  color: Colors.green.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.local_fire_department,
                      color: Colors.green,
                      size: 28,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Total Calories: ${totalCalories.toStringAsFixed(0)} kcal',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
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
