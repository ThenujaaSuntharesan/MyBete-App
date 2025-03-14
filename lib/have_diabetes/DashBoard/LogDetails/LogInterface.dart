import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LogEntryScreen extends StatefulWidget {
  @override
  _LogEntryScreenState createState() => _LogEntryScreenState();
}

class _LogEntryScreenState extends State<LogEntryScreen> {
  DateTime selectedDate = DateTime.now();
  double? bloodSugar;
  String? pills;
  double? bloodPressure;
  double? bodyWeight;
  List<String> selectedTrackingMoments = [];
  List<String> selectedFoodTypes = [];

  final List<String> trackingMoments = [
    "Breakfast", "Lunch", "Before Meal", "After Meal", "Fasting",
    "Snack", "Dinner", "Hypo Feeling", "Hyper Feeling"
  ];

  final List<String> foodTypes = [
    "Water", "Vegetables", "Fruits", "Grains", "Legumes",
    "Meat", "Fish", "Egg", "Nuts", "Fast Food", "Alcohol",
    "Diet Soda", "Soft Drinks"
  ];

  void _pickDateTime() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (pickedTime != null) {
        setState(() {
          selectedDate = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      }
    }
  }

  void _toggleSelection(List<String> list, String value) {
    setState(() {
      if (list.contains(value)) {
        list.remove(value);
      } else {
        list.add(value);
      }
    });
  }

  void _saveLog() {
    if (bloodSugar == null || bloodPressure == null || bodyWeight == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please fill in all required fields!")),
      );
      return;
    }

    Navigator.pop(context, {
      "time": DateFormat('HH:mm dd/MM/yyyy').format(selectedDate),
      "bloodSugar": bloodSugar,
      "pills": pills ?? "None",
      "bloodPressure": bloodPressure,
      "bodyWeight": bodyWeight,
      "trackingMoments": selectedTrackingMoments,
      "foodType": selectedFoodTypes,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Log Entry"),
        backgroundColor: Color(0xFF5FB8DD),
        actions: [IconButton(icon: Icon(Icons.check), onPressed: _saveLog)],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Date & Time Picker
              Text("Date & Time", style: TextStyle(fontWeight: FontWeight.bold)),
              TextFormField(
                readOnly: true,
                onTap: _pickDateTime,
                decoration: InputDecoration(
                  hintText: DateFormat('HH:mm dd/MM/yyyy').format(selectedDate),
                  suffixIcon: Icon(Icons.calendar_today),
                ),
              ),
              SizedBox(height: 15),

              // Blood Sugar
              Text("Blood Sugar (mg/dL)", style: TextStyle(fontWeight: FontWeight.bold)),
              TextFormField(
                keyboardType: TextInputType.number,
                onChanged: (value) => bloodSugar = double.tryParse(value),
                decoration: InputDecoration(hintText: "Enter value"),
              ),
              SizedBox(height: 15),

              // Pills
              Text("Pills (Optional)", style: TextStyle(fontWeight: FontWeight.bold)),
              TextFormField(
                onChanged: (value) => pills = value,
                decoration: InputDecoration(hintText: "Enter medication (if any)"),
              ),
              SizedBox(height: 15),

              // Blood Pressure
              Text("Blood Pressure (mmHg)", style: TextStyle(fontWeight: FontWeight.bold)),
              TextFormField(
                keyboardType: TextInputType.number,
                onChanged: (value) => bloodPressure = double.tryParse(value),
                decoration: InputDecoration(hintText: "Enter value"),
              ),
              SizedBox(height: 15),

              // Body Weight
              Text("Body Weight (kg)", style: TextStyle(fontWeight: FontWeight.bold)),
              TextFormField(
                keyboardType: TextInputType.number,
                onChanged: (value) => bodyWeight = double.tryParse(value),
                decoration: InputDecoration(hintText: "Enter value"),
              ),
              SizedBox(height: 20),

              // Blood Sugar Tracking Moment (Multiple Selection)
              Text("Blood Sugar Tracking Moment", style: TextStyle(fontWeight: FontWeight.bold)),
              Wrap(
                spacing: 8,
                children: trackingMoments.map((moment) {
                  bool isSelected = selectedTrackingMoments.contains(moment);
                  return ChoiceChip(
                    label: Text(moment),
                    selected: isSelected,
                    selectedColor: Colors.lightBlue[200],
                    onSelected: (selected) {
                      _toggleSelection(selectedTrackingMoments, moment);
                    },
                  );
                }).toList(),
              ),
              SizedBox(height: 20),

              // Food Type (Multiple Selection)
              Text("Food Type", style: TextStyle(fontWeight: FontWeight.bold)),
              Wrap(
                spacing: 8,
                children: foodTypes.map((food) {
                  bool isSelected = selectedFoodTypes.contains(food);
                  return ChoiceChip(
                    label: Text(food),
                    selected: isSelected,
                    selectedColor: Colors.orange[200],
                    onSelected: (selected) {
                      _toggleSelection(selectedFoodTypes, food);
                    },
                  );
                }).toList(),
              ),
              SizedBox(height: 20),

              // Save Button
              Center(
                child: ElevatedButton(
                  onPressed: _saveLog,
                  child: Text("Save Log"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF5FB8DD),
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
