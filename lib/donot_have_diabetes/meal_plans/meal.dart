import 'package:flutter/material.dart';
import 'package:mybete_app/donot_have_diabetes/meal_plans/meal_category.dart';
import 'package:intl/intl.dart';

// Singleton class to store meal calories data
class MealData {
  static final MealData _instance = MealData._internal();

  factory MealData() {
    return _instance;
  }

  MealData._internal();

  // Store calories for each meal type
  double breakfastCalories = 0;
  double lunchCalories = 0;
  double dinnerCalories = 0;
  double snackCalories = 0;

  // Calorie goals for each meal type
  double breakfastGoal = 500;
  double lunchGoal = 700;
  double dinnerGoal = 600;
  double snackGoal = 200;

  // Total calorie goal
  double calorieGoal = 2000;

  // Track selected recipes for each meal type
  final List<String> selectedBreakfastRecipes = [];
  final List<String> selectedLunchRecipes = [];
  final List<String> selectedDinnerRecipes = [];
  final List<String> selectedSnackRecipes = [];

  // Calculate total calories
  double get totalCalories =>
      breakfastCalories + lunchCalories + dinnerCalories + snackCalories;

  // Get percentage for each meal type
  double getPercentage(String mealType) {
    switch(mealType.toLowerCase()) {
      case 'breakfast':
        return breakfastCalories / breakfastGoal;
      case 'lunch':
        return lunchCalories / lunchGoal;
      case 'dinner':
        return dinnerCalories / dinnerGoal;
      case 'snack':
      case 'snacks':
        return snackCalories / snackGoal;
      default:
        return 0;
    }
  }

  // Add calories to a specific meal type
  void addCalories(String mealType, double calories) {
    switch(mealType.toLowerCase()) {
      case 'breakfast':
        breakfastCalories += calories;
        break;
      case 'lunch':
        lunchCalories += calories;
        break;
      case 'dinner':
        dinnerCalories += calories;
        break;
      case 'snack':
      case 'snacks':
        snackCalories += calories;
        break;
    }
  }

  // Add a recipe to the selected recipes list
  void addRecipe(String mealType, String recipeName) {
    switch(mealType.toLowerCase()) {
      case 'breakfast':
        if (!selectedBreakfastRecipes.contains(recipeName)) {
          selectedBreakfastRecipes.add(recipeName);
        }
        break;
      case 'lunch':
        if (!selectedLunchRecipes.contains(recipeName)) {
          selectedLunchRecipes.add(recipeName);
        }
        break;
      case 'dinner':
        if (!selectedDinnerRecipes.contains(recipeName)) {
          selectedDinnerRecipes.add(recipeName);
        }
        break;
      case 'snack':
      case 'snacks':
        if (!selectedSnackRecipes.contains(recipeName)) {
          selectedSnackRecipes.add(recipeName);
        }
        break;
    }
  }

  // Check if a recipe is selected
  bool isRecipeSelected(String mealType, String recipeName) {
    switch(mealType.toLowerCase()) {
      case 'breakfast':
        return selectedBreakfastRecipes.contains(recipeName);
      case 'lunch':
        return selectedLunchRecipes.contains(recipeName);
      case 'dinner':
        return selectedDinnerRecipes.contains(recipeName);
      case 'snack':
      case 'snacks':
        return selectedSnackRecipes.contains(recipeName);
      default:
        return false;
    }
  }

  // Remove a recipe from the selected recipes list
  void removeRecipe(String mealType, String recipeName) {
    switch(mealType.toLowerCase()) {
      case 'breakfast':
        selectedBreakfastRecipes.remove(recipeName);
        break;
      case 'lunch':
        selectedLunchRecipes.remove(recipeName);
        break;
      case 'dinner':
        selectedDinnerRecipes.remove(recipeName);
        break;
      case 'snack':
      case 'snacks':
        selectedSnackRecipes.remove(recipeName);
        break;
    }
  }

  // Update calorie goal
  void updateCalorieGoal(double goal) {
    calorieGoal = goal;
    // Distribute the goal across meal types (example distribution)
    breakfastGoal = goal * 0.25; // 25% of total
    lunchGoal = goal * 0.35;     // 35% of total
    dinnerGoal = goal * 0.30;    // 30% of total
    snackGoal = goal * 0.10;     // 10% of total
  }

  // Reset calories for a specific meal type
  void resetCalories(String mealType) {
    switch(mealType.toLowerCase()) {
      case 'breakfast':
        breakfastCalories = 0;
        break;
      case 'lunch':
        lunchCalories = 0;
        break;
      case 'dinner':
        dinnerCalories = 0;
        break;
      case 'snack':
      case 'snacks':
        snackCalories = 0;
        break;
      case 'all':
        breakfastCalories = 0;
        lunchCalories = 0;
        dinnerCalories = 0;
        snackCalories = 0;
        break;
    }
  }
}

class MealPlannerScreen extends StatefulWidget {
  const MealPlannerScreen({Key? key}) : super(key: key);

  @override
  State<MealPlannerScreen> createState() => _MealPlannerScreenState();
}

class _MealPlannerScreenState extends State<MealPlannerScreen> with SingleTickerProviderStateMixin {
  final MealData _mealData = MealData();
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  final TextEditingController _goalController = TextEditingController();

  // Current time to suggest meal type
  late String _currentMealType;

  // Scroll controllers for horizontal scrolling
  final ScrollController _breakfastScrollController = ScrollController();
  final ScrollController _lunchScrollController = ScrollController();
  final ScrollController _dinnerScrollController = ScrollController();
  final ScrollController _snacksScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
    _animationController.forward();
    _goalController.text = _mealData.calorieGoal.toString();

    // Determine current meal type based on time of day
    _currentMealType = _getCurrentMealType();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _goalController.dispose();
    _breakfastScrollController.dispose();
    _lunchScrollController.dispose();
    _dinnerScrollController.dispose();
    _snacksScrollController.dispose();
    super.dispose();
  }

  // Determine current meal type based on time of day
  String _getCurrentMealType() {
    final int currentHour = DateTime.now().hour;

    if (currentHour >= 5 && currentHour < 11) {
      return 'Breakfast';
    } else if (currentHour >= 11 && currentHour < 15) {
      return 'Lunch';
    } else if (currentHour >= 15 && currentHour < 20) {
      return 'Snacks';
    } else {
      return 'Dinner';
    }
  }

  void _updateState() {
    setState(() {});
  }

  void _addCaloriesToMeal(String mealType, double calories) {
    setState(() {
      _mealData.addCalories(mealType, calories);
    });
  }

  void _toggleRecipeSelection(String mealType, String recipeName, double calories) {
    setState(() {
      if (_mealData.isRecipeSelected(mealType, recipeName)) {
        _mealData.removeRecipe(mealType, recipeName);
        // Subtract calories when removing a recipe
        _mealData.addCalories(mealType, -calories);
      } else {
        _mealData.addRecipe(mealType, recipeName);
        // Add calories when adding a recipe
        _mealData.addCalories(mealType, calories);
      }
    });

    // Show confirmation
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
            _mealData.isRecipeSelected(mealType, recipeName)
                ? 'Added $recipeName to your $mealType'
                : 'Removed $recipeName from your $mealType'
        ),
        backgroundColor: _mealData.isRecipeSelected(mealType, recipeName)
            ? Colors.green
            : Colors.orange,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  void _updateCalorieGoal() {
    final double? newGoal = double.tryParse(_goalController.text);
    if (newGoal != null && newGoal > 0) {
      setState(() {
        _mealData.updateCalorieGoal(newGoal);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Calorie goal updated to ${newGoal.toInt()} kcal'),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
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
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: Row(
                children: [
                  // Back Button
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, size: 24),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      tooltip: 'Back',
                    ),
                  ),
                  const Spacer(),
                  // Current time and suggested meal
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.access_time, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          DateFormat('h:mm a').format(DateTime.now()),
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Total calories display
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.blue.shade400, Colors.blue.shade600],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue.withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.local_fire_department,
                          color: Colors.white,
                          size: 20,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          '${_mealData.totalCalories.toInt()} kcal',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Main Content
            Expanded(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  physics: const BouncingScrollPhysics(),
                  children: [
                    const SizedBox(height: 20),

                    // Header with gradient text
                    ShaderMask(
                      shaderCallback: (bounds) => const LinearGradient(
                        colors: [
                          Color(0xFF0066FF),
                          Color(0xFF00CCFF),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ).createShader(bounds),
                      child: const Text(
                        'Meal Planner',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),

                    const SizedBox(height: 8),
                    Text(
                      'Plan your daily meals and track your calories',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Current meal suggestion
                    _buildCurrentMealSuggestion(),

                    const SizedBox(height: 24),

                    // Calorie Goal Section
                    _buildCalorieGoalSection(),

                    const SizedBox(height: 24),

                    // Daily Progress Indicator
                    _buildProgressIndicator(),

                    const SizedBox(height: 24),

                    // Meal Progress Circles
                    _buildMealProgressCircles(),

                    const SizedBox(height: 24),




                    // Calorie Summary
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.pie_chart,
                                color: Colors.blue,
                                size: 22,
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                'Calorie Summary',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                'Daily',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          _calorieRow('Breakfast', _mealData.breakfastCalories, Colors.amber, goalCalories: _mealData.breakfastGoal),
                          _calorieRow('Lunch', _mealData.lunchCalories, Colors.green, goalCalories: _mealData.lunchGoal),
                          _calorieRow('Dinner', _mealData.dinnerCalories, Colors.purple, goalCalories: _mealData.dinnerGoal),
                          _calorieRow('Snacks', _mealData.snackCalories, Colors.orange, goalCalories: _mealData.snackGoal),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 12.0),
                            child: Divider(height: 1),
                          ),
                          _calorieRow('Total', _mealData.totalCalories, Colors.blue, isTotal: true, goalCalories: _mealData.calorieGoal),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Nutrition Tips
                    _buildNutritionTips(),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),

            // Bottom Navigation Bar
            Container(
              height: 70,
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
                    label: 'Meals',
                    color: Colors.blue,
                    isSelected: true,
                  ),
                  NavBarItem(
                    icon: Icons.favorite,
                    label: 'Favorites',
                    color: Colors.grey.shade700,
                    isSelected: false,
                  ),
                  NavBarItem(
                    icon: Icons.fitness_center,
                    label: 'Exercise',
                    color: Colors.grey.shade700,
                    isSelected: false,
                  ),
                  NavBarItem(
                    icon: Icons.person,
                    label: 'Profile',
                    color: Colors.grey.shade700,
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

  Widget _buildCurrentMealSuggestion() {
    Color bgColor;
    IconData icon;

    switch(_currentMealType) {
      case 'Breakfast':
        bgColor = Colors.amber.shade100;
        icon = Icons.wb_sunny;
        break;
      case 'Lunch':
        bgColor = Colors.green.shade100;
        icon = Icons.restaurant;
        break;
      case 'Dinner':
        bgColor = Colors.purple.shade100;
        icon = Icons.nightlight;
        break;
      case 'Snacks':
      default:
        bgColor = Colors.orange.shade100;
        icon = Icons.cookie;
        break;
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(icon, size: 24, color: Colors.black),
          const SizedBox(width: 10),
          Expanded(  // ✅ Prevents overflow
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'It\'s $_currentMealType time!',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5), // Reduced from 30 to avoid extra space
                Text(
                  'Add your $_currentMealType to track calories',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FoodCategoryScreen(mealType: _currentMealType),
                ),
              ).then((_) => _updateState());
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
            child: const Text('Add Now'),
          ),
        ],
      ),
    );
  }

  Widget _buildCalorieGoalSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.shade500, Colors.blue.shade700],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(
                Icons.flag,
                color: Colors.white,
                size: 22,
              ),
              SizedBox(width: 8),
              Text(
                'Set Your Calorie Goal',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextField(
                    controller: _goalController,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      border: InputBorder.none,
                      hintText: 'Enter daily calorie goal',
                      hintStyle: TextStyle(
                        color: Colors.grey.shade400,
                        fontWeight: FontWeight.normal,
                      ),
                      suffixText: 'kcal',
                      suffixStyle: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              ElevatedButton(
                onPressed: _updateCalorieGoal,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.blue.shade700,
                  padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Save',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMealProgressCircles() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(
                Icons.donut_large,
                color: Colors.blue,
                size: 22,
              ),
              SizedBox(width: 8),
              Text(
                'Meal Progress',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildProgressCircle('Breakfast', _mealData.getPercentage('breakfast'), Colors.amber),
              _buildProgressCircle('Lunch', _mealData.getPercentage('lunch'), Colors.green),
              _buildProgressCircle('Dinner', _mealData.getPercentage('dinner'), Colors.purple),
              _buildProgressCircle('Snacks', _mealData.getPercentage('snacks'), Colors.orange),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProgressCircle(String label, double percentage, Color color) {
    final double clampedPercentage = percentage.clamp(0.0, 1.0);
    return Column(
      children: [
        SizedBox(
          height: 70,
          width: 70,
          child: Stack(
            children: [
              // Background circle
              Container(
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
              ),
              // Progress circle
              Center(
                child: SizedBox(
                  height: 70,
                  width: 70,
                  child: CircularProgressIndicator(
                    value: clampedPercentage,
                    strokeWidth: 8,
                    backgroundColor: Colors.transparent,
                    valueColor: AlwaysStoppedAnimation<Color>(color),
                  ),
                ),
              ),
              // Percentage text
              Center(
                child: Text(
                  '${(clampedPercentage * 100).toInt()}%',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _buildMealTypeHeader(String title, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        TextButton(
          onPressed: () {
            // Navigate to see all items for this meal type
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FoodCategoryScreen(mealType: title),
              ),
            ).then((_) => _updateState());
          },
          child: Text(
            'See All',
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

    Widget _buildProgressIndicator() {
      final double progress = (_mealData.totalCalories / _mealData.calorieGoal).clamp(0.0, 1.0);

      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade50, Colors.blue.shade100],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Daily Progress',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${(progress * 100).toInt()}%',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: progress > 0.9 ? Colors.red : Colors.blue.shade700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Stack(
              children: [
                // Background
                Container(
                  height: 12,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                // Progress
                AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                  height: 12,
                  width: MediaQuery.of(context).size.width * progress * 0.8, // Adjust for padding
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: progress > 0.9
                          ? [Colors.red.shade400, Colors.red.shade600]
                          : [Colors.blue.shade400, Colors.blue.shade600],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${_mealData.totalCalories.toInt()} kcal consumed',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
                Text(
                  '${_mealData.calorieGoal.toInt()} kcal target',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    Widget _buildNutritionTips() {
      return Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.blue.shade100),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.lightbulb_outline,
                  color: Colors.amber.shade700,
                  size: 22,
                ),
                const SizedBox(width: 8),
                const Text(
                  'Nutrition Tips',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _tipItem(
              'Balance your plate with proteins, carbs, and healthy fats.',
              Icons.balance,
            ),
            _tipItem(
              'Stay hydrated! Aim for 8 glasses of water daily.',
              Icons.water_drop,
            ),
            _tipItem(
              'Include colorful vegetables in every meal.',
              Icons.color_lens,
            ),
          ],
        ),
      );
    }

    Widget _tipItem(String tip, IconData icon) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              size: 18,
              color: Colors.blue.shade600,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                tip,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget _calorieRow(String label, double calories, Color color, {bool isTotal = false, required double goalCalories}) {
      final double percentage = (calories / goalCalories).clamp(0.0, 1.0);

      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      label,
                      style: TextStyle(
                        fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
                        fontSize: isTotal ? 16 : 14,
                      ),
                    ),
                  ],
                ),
                Text(
                  '${calories.toInt()} / ${goalCalories.toInt()} kcal',
                  style: TextStyle(
                    fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
                    fontSize: isTotal ? 16 : 14,
                    color: isTotal ? Colors.blue.shade700 : Colors.grey.shade800,
                  ),
                ),
              ],
            ),
            if (!isTotal) ...[
              const SizedBox(height: 6),
              Stack(
                children: [
                  // Background
                  Container(
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  // Progress
                  Container(
                    height: 4,
                    width: MediaQuery.of(context).size.width * 0.65 * percentage, // Adjust for padding
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      );
    }
  }


class NavBarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final bool isSelected;

  const NavBarItem({
    Key? key,
    required this.icon,
    required this.label,
    required this.color,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? Colors.blue.shade50 : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 24,
            color: color,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
