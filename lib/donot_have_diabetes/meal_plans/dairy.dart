import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'total_screen.dart'; // Add this line

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'SF Pro Display',
        scaffoldBackgroundColor: const Color(0xFFE3F2FD),
      ),
      home: const DairyProductsScreen(),
    );
  }
}

class DairyProductsScreen extends StatelessWidget {
  const DairyProductsScreen({Key? key}) : super(key: key);

  // Function to add calorie to Firestore
  void _addCalorieToFirebase(String name, int calories) async {
    final userId = 'user123'; // Replace with actual user ID
    final userRef = FirebaseFirestore.instance.collection('users').doc(userId);

    try {
      // Get the current total calorie count for the user
      final userDoc = await userRef.get();
      int totalCalories = 0;

      if (userDoc.exists) {
        // If user document exists, fetch total calories (or set to 0 if not present)
        totalCalories = userDoc.data()?['total_calories'] ?? 0;
      }

      // Update the total calorie count by adding the vegetable's calories
      totalCalories += calories;

      // Save the updated total calorie count back to Firestore
      await userRef.set({
        'total_calories': totalCalories,
      }, SetOptions(merge: true));

      // Optionally: You can also add a document in a subcollection for individual vegetables
      await userRef.collection('dairy_calories').add({
        'name': name,
        'calories': calories,
        'timestamp': FieldValue.serverTimestamp(), // Adds a timestamp for the entry
      });

      print("Calories added successfully!");
    } catch (e) {
      print("Error adding calories: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Status Bar and Back Button
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0),
              child: Row(
                children: [
                  // Back Button
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context); // Navigates back to the previous screen
                    },
                    child: const Icon(
                      Icons.arrow_back,
                      size: 30,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),

            // Main Content
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),

                      // Dairy Products Title
                      const Text(
                        'Dairy Products',
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Search Bar
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF3E5F5),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(
                            children: const [
                              Icon(
                                Icons.search,
                                color: Colors.grey,
                              ),
                              SizedBox(width: 8),
                              Expanded(
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: 'Search dairy products',
                                    border: InputBorder.none,
                                    hintStyle: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Low-Calorie Dairy Items Section
                      const Text(
                        'Low-Calorie Dairy Items',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const Text(
                        '(Below 100 kcal per 100g)',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Low-Calorie Dairy Items Grid
                      SizedBox(
                        height: 200, // Set a fixed height for the horizontal scroll area
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                            DairyItemCard(
                              name: 'Skim Milk',
                              calories: 34,
                              imagePath: 'lib/donot_have_diabetes/meal_plans/meal_images/milk-carton.png',
                              onAdd: (name, calories) {
                                _addCalorieToFirebase(name, calories);
                              },
                            ),

                          const SizedBox(width: 12),
                          DairyItemCard(
                              name: 'Low-fat Milk(1%)',
                              calories: 42,
                              imagePath: 'lib/donot_have_diabetes/meal_plans/meal_images/milk.png',
                              onAdd: (name, calories) {
                                _addCalorieToFirebase(name, calories);
                              },
                            ),

                          const SizedBox(width: 12),
                          DairyItemCard(
                              name: 'Buttermilk',
                              calories: 40,
                              imagePath: 'lib/donot_have_diabetes/meal_plans/meal_images/milk (1).png',
                              onAdd: (name, calories) {
                                _addCalorieToFirebase(name, calories);
                              },
                            ),

                              const SizedBox(width: 12),
                              DairyItemCard(
                                name: 'Plain Greek Yogurt (Non fat)',
                                calories: 59,
                                imagePath: 'lib/donot_have_diabetes/meal_plans/meal_images/milk.png',
                                onAdd: (name, calories) {
                                  _addCalorieToFirebase(name, calories);
                                },
                              ),

                              const SizedBox(width: 12),
                              DairyItemCard(
                                name: 'Cottage Cheese(Low fat 1%)',
                                calories: 72,
                                imagePath: 'lib/donot_have_diabetes/meal_plans/meal_images/milk.png',
                                onAdd: (name, calories) {
                                  _addCalorieToFirebase(name, calories);
                                },
                              ),

                              const SizedBox(width: 12),
                              DairyItemCard(
                                name: 'Plain Yorgurt(non fat)',
                                calories: 58,
                                imagePath: 'lib/donot_have_diabetes/meal_plans/meal_images/milk.png',
                                onAdd: (name, calories) {
                                  _addCalorieToFirebase(name, calories);
                                },
                              ),
                            ],
                          ),
                          ),
                        ),

                      const SizedBox(height: 24),

                      // Moderate-Calorie Dairy Items Section
                      const Text(
                        'Moderate-Calorie Dairy Items',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,

                        ),
                      ),

                      const Text(
                        '(100-350 kcal per 100g)',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,

                        ),
                      ),

                      const SizedBox(height: 16),

                      // Moderate-Calorie Dairy Items Grid
                      SizedBox(
                        height: 200, // Set a fixed height for the horizontal scroll area
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                            DairyItemCard(
                              name: 'Whole Milk',
                              calories: 61,
                              imagePath: 'lib/donot_have_diabetes/meal_plans/meal_images/milk-box.png',
                              onAdd: (name, calories) {
                                _addCalorieToFirebase(name, calories);
                              },
                            ),

                          const SizedBox(width: 12),
                          DairyItemCard(
                              name: 'Plain Yogurt (Whole Milk)',
                              calories: 61,
                              imagePath: 'assets/plain_yogurt.png',
                              onAdd: (name, calories) {
                                _addCalorieToFirebase(name, calories);
                              },
                            ),

                          const SizedBox(width: 12),
                          DairyItemCard(
                              name: 'Greek Yogurt (Whole Milk)',
                              calories: 97,
                              imagePath: 'assets/greek_yogurt.png',
                              onAdd: (name, calories) {
                                _addCalorieToFirebase(name, calories);
                              },
                          ),

                              const SizedBox(width: 12),
                              DairyItemCard(
                                name: 'Cottage Cheese (Full Fat)',
                                calories: 98,
                                imagePath: 'lib/donot_have_diabetes/meal_plans/meal_images/milk.png',
                                onAdd: (name, calories) {
                                  _addCalorieToFirebase(name, calories);
                                },
                              ),

                              const SizedBox(width: 12),
                              DairyItemCard(
                                name: 'Cream Cheese (Low Fat)',
                                calories: 180,
                                imagePath: 'lib/donot_have_diabetes/meal_plans/meal_images/milk.png',
                                onAdd: (name, calories) {
                                  _addCalorieToFirebase(name, calories);
                                },
                              ),

                              const SizedBox(width: 12),
                              DairyItemCard(
                                name: 'Low-fat Milk(1%)',
                                calories: 42,
                                imagePath: 'lib/donot_have_diabetes/meal_plans/meal_images/milk.png',
                                onAdd: (name, calories) {
                                  _addCalorieToFirebase(name, calories);
                                },
                              ),

                              const SizedBox(width: 12),
                              DairyItemCard(
                                name: 'Mozzarella Cheese (Part-Skim)',
                                calories: 280,
                                imagePath: 'lib/donot_have_diabetes/meal_plans/meal_images/milk.png',
                                onAdd: (name, calories) {
                                  _addCalorieToFirebase(name, calories);
                                },
                              ),

                              const SizedBox(width: 12),
                              DairyItemCard(
                                name: 'Parmesan Cheese (Grated)',
                                calories: 321,
                                imagePath: 'lib/donot_have_diabetes/meal_plans/meal_images/milk.png',
                                onAdd: (name, calories) {
                                  _addCalorieToFirebase(name, calories);
                                },
                              ),
                            ],
                          ),
                        ),
                      ),


                      const SizedBox(height: 24),

                      // High-Calorie Dairy Items Section
                      const Text(
                        'High-Calorie Dairy Items',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const Text(
                        '(Above 350 kcal per 100g)',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 16),

                      // High-Calorie Dairy Items Grid
                      SizedBox(
                        height: 200, // Reduced height for consistency with other sections
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                            DairyItemCard(
                              name: 'Butter',
                              calories: 717,
                              imagePath: 'assets/butter.png',
                              onAdd: (name, calories) {
                                _addCalorieToFirebase(name, calories);
                              },
                            ),

                          const SizedBox(width: 12),
                          DairyItemCard(
                              name: 'Heavy Cream',
                              calories: 340,
                              imagePath: 'assets/heavy_cream.png',
                              onAdd: (name, calories) {
                                _addCalorieToFirebase(name, calories);
                              },
                            ),

                          const SizedBox(width: 12),
                          DairyItemCard(
                              name: 'Cheddar Cheese',
                              calories: 403,
                              imagePath: 'assets/cheddar_cheese.png',
                              onAdd: (name, calories) {
                                _addCalorieToFirebase(name, calories);
                              },
                          ),

                              const SizedBox(width: 12),
                              DairyItemCard(
                                name: 'Swiss Cheese',
                                calories: 393,
                                imagePath: 'assets/cheddar_cheese.png',
                                onAdd: (name, calories) {
                                  _addCalorieToFirebase(name, calories);
                                },
                              ),

                              const SizedBox(width: 12),
                              DairyItemCard(
                                name: 'Cream Cheese (Full Fat)',
                                calories: 340,
                                imagePath: 'assets/cheddar_cheese.png',
                                onAdd: (name, calories) {
                                  _addCalorieToFirebase(name, calories);
                                },
                              ),


                            ],
                          ),
                        ),
                      ),


                      // Add View Total Calories Button
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Center(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const TotalScreen(category: 'Dairy')), // Navigate to TotalScreen
                              );
                            },
                            child: const Text(
                              'View Total Calories',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
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
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  NavBarItem(
                    icon: Icons.menu_book,
                    color: Colors.blue,
                    isSelected: true,
                  ),
                  NavBarItem(
                    icon: Icons.favorite,
                    color: Colors.black,
                    isSelected: false,
                  ),
                  NavBarItem(
                    icon: Icons.fitness_center,
                    color: Colors.black,
                    isSelected: false,
                  ),
                  NavBarItem(
                    icon: Icons.person,
                    color: Colors.black,
                    isSelected: false,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DairyItemCard extends StatelessWidget {
  final String name;
  final int calories;
  final String imagePath;
  final Function(String, int) onAdd;

  const DairyItemCard({
    Key? key,
    required this.name,
    required this.calories,
    required this.imagePath,
    required this.onAdd,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            // Dairy Item Image
            SizedBox(
              height: 100,
              child: Image.asset(
                imagePath,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 80,
                  color: Colors.grey.shade200,
                  child: const Icon(Icons.image, size: 80),
                ),
              ),
            ),

            const SizedBox(height: 15),

            // Dairy Item Name
            Text(
              name,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 4),

            // Calorie Info and Add Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '$calories kcal',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF00C853),
                  ),
                ),

                GestureDetector(
                  onTap: () {
                    onAdd(name, calories);  // Trigger the onAdd callback with proper parameters

                    // Show a snackbar to confirm addition
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Added $name ($calories kcal)'),
                        duration: const Duration(seconds: 1),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                  child: Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: const Color(0xFF00FF62),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class NavBarItem extends StatelessWidget {
  final IconData icon;
  final Color color;
  final bool isSelected;

  const NavBarItem({
    Key? key,
    required this.icon,
    required this.color,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Icon(
        icon,
        size: 28,
        color: color,
      ),
    );
  }
}