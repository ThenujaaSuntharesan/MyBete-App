import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';
import 'summary.dart';

class TotalScreen extends StatefulWidget {
  final String category;
  const TotalScreen({Key? key, required this.category}) : super(key: key);

  @override
  _TotalScreenState createState() => _TotalScreenState();
}

class _TotalScreenState extends State<TotalScreen> {
  List<Map<String, dynamic>> clickedItems = [];
  num totalCalories = 0;
  bool isLoading = true;

  void _fetchClickedItems() async {
    setState(() {
      isLoading = true;
    });

    final userId = 'user123'; // Replace with the actual user ID
    final userRef = FirebaseFirestore.instance.collection('users').doc(userId);

    try {
      // Get items from the vegetable_calories subcollection
      final querySnapshot = await userRef.collection('vegetable_calories').get();

      num caloriesSum = 0;
      List<Map<String, dynamic>> items = [];

      for (var doc in querySnapshot.docs) {
        final data = doc.data();
        final name = data['name'];
        final calories = data['calories'];
        final timestamp = data['timestamp']; // This might be useful for sorting

        items.add({
          'id': doc.id,
          'name': name,
          'calories': calories,
          'timestamp': timestamp,
        });

        if (calories is num) {
          caloriesSum += calories;
        }
      }

      // Sort items by timestamp (newest first) if timestamp exists
      items.sort((a, b) {
        final aTimestamp = a['timestamp'];
        final bTimestamp = b['timestamp'];
        if (aTimestamp == null || bTimestamp == null) return 0;
        return bTimestamp.compareTo(aTimestamp);
      });

      setState(() {
        clickedItems = items;
        totalCalories = caloriesSum;
        isLoading = false;
      });
    } catch (e) {
      print("Error fetching items: $e");
      setState(() {
        isLoading = false;
      });
    }
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
        title: Text('${widget.category.capitalize()} - Total Calories'),
        backgroundColor: const Color(0xFF00FF62),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Header with total calories
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFE5FFED),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Text(
                    'Total Calories Consumed',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.local_fire_department,
                        color: Color(0xFF009439),
                        size: 32,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${totalCalories.toStringAsFixed(0)} kcal',
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF009439),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // List of added items
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : clickedItems.isEmpty
                  ? const Center(
                child: Text(
                  'No items added yet',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                  ),
                ),
              )
                  : ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: clickedItems.length,
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, index) {
                  final item = clickedItems[index];
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      item['name'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '${item['calories']} kcal',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF009439),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.delete_outline,
                            color: Colors.red,
                          ),
                          onPressed: () => _deleteItem(item['id']),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      // Add a floating action button to navigate to the summary screen
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SummaryScreen()),
          );
        },
        backgroundColor: const Color(0xFF00FF62),
        child: const Icon(Icons.pie_chart),
        tooltip: 'View Summary',
      ),
    );
  }



  // Method to delete an item
  void _deleteItem(String id) async {
    final userId = 'user123'; // Replace with the actual user ID
    final userRef = FirebaseFirestore.instance.collection('users').doc(userId);

    try {
      // Get the item to calculate calories to subtract
      final docSnapshot = await userRef.collection('vegetable_calories').doc(id).get();
      final data = docSnapshot.data();
      final calories = data?['calories'] ?? 0;

      // Delete the item
      await userRef.collection('vegetable_calories').doc(id).delete();

      // Update total calories in the user document
      final userDoc = await userRef.get();
      if (userDoc.exists) {
        final currentTotal = userDoc.data()?['total_calories'] ?? 0;
        await userRef.update({
          'total_calories': currentTotal - calories,
        });
      }

      // Refresh the list
      _fetchClickedItems();

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Item deleted successfully'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      print("Error deleting item: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to delete item'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}

// Extension to capitalize the first letter of a string
extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}