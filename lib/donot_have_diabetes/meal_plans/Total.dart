import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => CalorieTracker(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'SF Pro Display',
        scaffoldBackgroundColor: const Color(0xFFCCEEFF), // Light blue background
      ),
      home: const TotalCaloriesScreen(),
    );
  }
}

// Model for food items
class FoodItem {
  final String name;
  final int calories;
  final String category;

  FoodItem({
    required this.name,
    required this.calories,
    required this.category,
  });
}

// State management for calorie tracking
class CalorieTracker extends ChangeNotifier {
  final List<FoodItem> _selectedItems = [];

  List<FoodItem> get selectedItems => _selectedItems;

  int get totalCalories => _selectedItems.fold(0, (sum, item) => sum + item.calories);

  void addItem(FoodItem item) {
    _selectedItems.add(item);
    notifyListeners();
  }

  void removeItem(int index) {
    _selectedItems.removeAt(index);
    notifyListeners();
  }
}

// Sample food database
class FoodDatabase {
  static List<FoodItem> vegetables = [
    FoodItem(name: 'Potatoes', calories: 86, category: 'Vegetables'),
    FoodItem(name: 'Carrots', calories: 41, category: 'Vegetables'),
    FoodItem(name: 'Broccoli', calories: 34, category: 'Vegetables'),
    FoodItem(name: 'Spinach', calories: 23, category: 'Vegetables'),
  ];

  static List<FoodItem> fruits = [
    FoodItem(name: 'Apple', calories: 52, category: 'Fruits'),
    FoodItem(name: 'Banana', calories: 89, category: 'Fruits'),
    FoodItem(name: 'Orange', calories: 47, category: 'Fruits'),
    FoodItem(name: 'Strawberries', calories: 32, category: 'Fruits'),
  ];

  static List<FoodItem> beverages = [
    FoodItem(name: 'Water', calories: 0, category: 'Beverages'),
    FoodItem(name: 'Black Coffee', calories: 2, category: 'Beverages'),
    FoodItem(name: 'Orange Juice', calories: 45, category: 'Beverages'),
    FoodItem(name: 'Milk', calories: 42, category: 'Beverages'),
  ];

  static List<FoodItem> getAllFoods() {
    return [...vegetables, ...fruits, ...beverages];
  }
}

// Screen to display total calories
class TotalCaloriesScreen extends StatelessWidget {
  const TotalCaloriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      // Handle back button press
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.arrow_back,
                      size: 28,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Text(
                    'Total of Calories',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const Spacer(),
                  const Text(
                    'kcal',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),

            // List of selected food items
            Expanded(
              child: Consumer<CalorieTracker>(
                builder: (context, calorieTracker, child) {
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    itemCount: calorieTracker.selectedItems.length,
                    itemBuilder: (context, index) {
                      final item = calorieTracker.selectedItems[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                            child: Row(
                              children: [
                                // Remove button
                                GestureDetector(
                                  onTap: () {
                                    calorieTracker.removeItem(index);
                                  },
                                  child: Container(
                                    width: 36,
                                    height: 36,
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.remove,
                                      color: Colors.white,
                                      size: 24,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                // Food name
                                Expanded(
                                  child: Text(
                                    item.name,
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                // Calories
                                Text(
                                  item.calories.toString(),
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),

            // Total calories footer
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              decoration: const BoxDecoration(
                color: Color(0xFF33AAFF),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total Calories',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFEE44),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Consumer<CalorieTracker>(
                      builder: (context, calorieTracker, child) {
                        return Text(
                          calorieTracker.totalCalories.toString(),
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF550088),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            // Bottom Navigation Bar
            Container(
              height: 60,
              color: const Color(0xFF33AAFF),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildNavBarItem(Icons.book, true),
                  _buildNavBarItem(Icons.favorite, false),
                  _buildNavBarItem(Icons.fitness_center, false),
                  _buildNavBarItem(Icons.person, false),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showFoodCategoriesDialog(context);
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
      ),
    );
  }

  // Helper method to build bottom navigation bar items
  Widget _buildNavBarItem(IconData icon, bool isSelected) {
    return Icon(
      icon,
      size: 28,
      color: isSelected ? Colors.white : Colors.black54,
    );
  }

  // Show dialog to select food category
  void _showFoodCategoriesDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Category'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildCategoryButton(context, 'Vegetables'),
              _buildCategoryButton(context, 'Fruits'),
              _buildCategoryButton(context, 'Beverages'),
            ],
          ),
        );
      },
    );
  }

  // Helper method to build category buttons
  Widget _buildCategoryButton(BuildContext context, String category) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton(
        onPressed: () {
          Navigator.pop(context);
          _showFoodItemsDialog(context, category);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          minimumSize: const Size(double.infinity, 50),
        ),
        child: Text(
          category,
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }

  // Show dialog to select food items from a category
  void _showFoodItemsDialog(BuildContext context, String category) {
    List<FoodItem> foodItems;

    switch (category) {
      case 'Vegetables':
        foodItems = FoodDatabase.vegetables;
        break;
      case 'Fruits':
        foodItems = FoodDatabase.fruits;
        break;
      case 'Beverages':
        foodItems = FoodDatabase.beverages;
        break;
      default:
        foodItems = [];
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select $category'),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: foodItems.length,
              itemBuilder: (context, index) {
                final item = foodItems[index];
                return ListTile(
                  title: Text(item.name),
                  subtitle: Text('${item.calories} kcal'),
                  trailing: IconButton(
                    icon: const Icon(Icons.add_circle, color: Colors.green),
                    onPressed: () {
                      Provider.of<CalorieTracker>(context, listen: false).addItem(item);
                      Navigator.pop(context);
                    },
                  ),
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}