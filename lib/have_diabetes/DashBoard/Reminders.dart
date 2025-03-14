import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class RemindersScreen extends StatefulWidget {
  @override
  _RemindersScreenState createState() => _RemindersScreenState();
}

class _RemindersScreenState extends State<RemindersScreen> {
  List<Map<String, dynamic>> reminders = [];

  @override
  void initState() {
    super.initState();
    _loadReminders();
  }

  Future<void> _loadReminders() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? data = prefs.getString('reminders');
    if (data != null) {
      setState(() {
        reminders = List<Map<String, dynamic>>.from(jsonDecode(data));
      });
    }
  }

  Future<void> _deleteReminder(int index) async {
    setState(() {
      reminders.removeAt(index);
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('reminders', jsonEncode(reminders));
  }

  void _editReminder(int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ReminderSetupScreen(reminder: reminders[index], index: index),
      ),
    ).then((_) => _loadReminders());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Reminders")),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ReminderSetupScreen(),
              ),
            ).then((_) => _loadReminders()),
            child: Text("+ Add Reminder"),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: reminders.length,
              itemBuilder: (context, index) {
                var reminder = reminders[index];
                return ListTile(
                  title: Text(reminder['title']),
                  subtitle: Text("${reminder['date']} at ${reminder['time']}"),
                    trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () => _editReminder(index),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => _deleteReminder(index),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ReminderSetupScreen extends StatefulWidget {
  final Map<String, dynamic>? reminder;
  final int? index;

  ReminderSetupScreen({this.reminder, this.index});

  @override
  _ReminderSetupScreenState createState() => _ReminderSetupScreenState();
}

class _ReminderSetupScreenState extends State<ReminderSetupScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  @override
  void initState() {
    super.initState();
    if (widget.reminder != null) {
      titleController.text = widget.reminder!['title'];
      noteController.text = widget.reminder!['note'];
      selectedDate = DateTime.parse(widget.reminder!['date']);
      selectedTime = TimeOfDay.fromDateTime(DateTime.parse(widget.reminder!['time']));
    }
  }

  Future<void> _pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _pickTime() async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  Future<void> _saveReminder() async {
    if (titleController.text.isEmpty || selectedDate == null || selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please complete all fields")));
      return;
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Map<String, dynamic>> reminders = [];
    String? data = prefs.getString('reminders');
    if (data != null) {
      reminders = List<Map<String, dynamic>>.from(jsonDecode(data));
    }
    Map<String, dynamic> newReminder = {
      'title': titleController.text,
      'date': selectedDate.toString(),
      'time': selectedTime.toString(),
      'note': noteController.text,
    };
    if (widget.index != null) {
      reminders[widget.index!] = newReminder;
    } else {
      reminders.add(newReminder);
    }
    await prefs.setString('reminders', jsonEncode(reminders));
    Navigator.pop(context);
  }

  void _clearFields() {
    setState(() {
      titleController.clear();
      noteController.clear();
      selectedDate = null;
      selectedTime = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Set Reminder")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: titleController, decoration: InputDecoration(labelText: "Task Title")),
            ListTile(
              title: Text(selectedDate == null ? "Select Date" : selectedDate.toString().split(' ')[0]),
              trailing: Icon(Icons.calendar_today),
              onTap: _pickDate,
            ),
            ListTile(
              title: Text(selectedTime == null ? "Select Time" : selectedTime!.format(context)),
              trailing: Icon(Icons.access_time),
              onTap: _pickTime,
            ),
            TextField(controller: noteController, decoration: InputDecoration(labelText: "Note (Optional)")),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(onPressed: _saveReminder, child: Text("Save")),
                ElevatedButton(onPressed: _clearFields, child: Text("Clear")),
              ],
            ),
          ],
        ),
      ),
    );
  }
}






// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'reminder_service.dart'; // Import ReminderService
//
// class ReminderSetupScreen extends StatefulWidget {
//   final Reminder? reminder;
//   final int? index;
//
//   ReminderSetupScreen({this.reminder, this.index});
//
//   @override
//   _ReminderSetupScreenState createState() => _ReminderSetupScreenState();
// }
//
// class _ReminderSetupScreenState extends State<ReminderSetupScreen> {
//   TextEditingController titleController = TextEditingController();
//   TextEditingController noteController = TextEditingController();
//   TimeOfDay? selectedTime;
//   DateTime? startDate;
//   DateTime? endDate;
//   bool isOneTime = true; // Track selected tab (One Time/Repeat)
//   bool isDaily = true; // Track selected tab (Daily/Custom)
//   bool taskNeverEnds = true; // Track "Task Never Ends" toggle
//
//   @override
//   void initState() {
//     super.initState();
//     if (widget.reminder != null) {
//       titleController.text = widget.reminder!.taskTitle;
//       noteController.text = widget.reminder!.note;
//       selectedTime = TimeOfDay.fromDateTime(widget.reminder!.reminderTime);
//       // Determine if it's One Time or Repeat based on your data
//       isOneTime = widget.reminder!.reminderTime.difference(DateTime.now()).inDays <= 1;
//       // Determine if it's Daily or Custom based on your data
//       // Example:
//       isDaily = widget.reminder!.reminderTime.difference(DateTime.now()).inDays > 1; // Adjust logic as needed
//     }
//   }
//
//   Future<void> _pickTime() async {
//     TimeOfDay? picked = await showTimePicker(
//       context: context,
//       initialTime: selectedTime ?? TimeOfDay.now(),
//     );
//     if (picked != null) {
//       setState(() {
//         selectedTime = picked;
//       });
//     }
//   }
//
//   Future<void> _pickStartDate() async {
//     DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: startDate ?? DateTime.now(),
//       firstDate: DateTime.now(),
//       lastDate: DateTime(2101),
//     );
//     if (picked != null) {
//       setState(() {
//         startDate = picked;
//       });
//     }
//   }
//
//   Future<void> _pickEndDate() async {
//     DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: endDate ?? DateTime.now(),
//       firstDate: DateTime.now(),
//       lastDate: DateTime(2101),
//     );
//     if (picked != null) {
//       setState(() {
//         endDate = picked;
//       });
//     }
//   }
//
//   Future<void> _saveReminder() async {
//     if (titleController.text.isEmpty || selectedTime == null || startDate == null) {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please complete all fields")));
//       return;
//     }
//     // Logic for saving based on One Time, Daily, or Custom
//     // ...
//     Navigator.pop(context);
//   }
//
//   void _clearFields() {
//     setState(() {
//       titleController.clear();
//       noteController.clear();
//       selectedTime = null;
//       startDate = null;
//       endDate = null;
//       taskNeverEnds = true;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.pop(context); // Handle back button press
//           },
//         ),
//         title: Text("Reminders"),
//       ),
//       body: Padding(
//           padding: EdgeInsets.all(16.0),
//           child: Column(
//             children: [
//             Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               ElevatedButton(
//                 onPressed: () {
//                   setState(() {
//                     isOneTime = true;
//                   });
//                 },
//                 child: Text("One Time"),
//                 style: ElevatedButton.styleFrom(
//                   primary: isOneTime ? Colors.blue : Colors.grey, // Highlight selected tab
//                 ),
//               ),
//               SizedBox(width: 8.0),
//               ElevatedButton(
//                 onPressed: () {
//                   setState(() {
//                     isOneTime = false;
//                   });
//                 },
//                 child: Text("Repeat"),
//                 style: ElevatedButton.styleFrom(
//                   primary: isOneTime ? Colors.grey : Colors.blue, // Highlight selected tab
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 16.0),
//           if (!isOneTime) // Show Daily/Custom only for Repeat reminders
//       Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         ElevatedButton(
//           onPressed: () {
//             setState(() {
//               isDaily = true;
//             });
//           },
//           child: Text("Daily"),
//           style: ElevatedButton.styleFrom(
//             primary: isDaily ? Colors.blue : Colors.grey, // Highlight selected tab
//           ),
//         ),
//         SizedBox(width: 8.0),
//         ElevatedButton(
//           onPressed: () {
//             setState(() {
//               isDaily = false;
//             });
//           },
//           child: Text("Custom"),
//           style: ElevatedButton.styleFrom(
//             primary: isDaily ? Colors.grey : Colors.blue, // Highlight selected tab
//           ),
//         ),
//       ],
//     ),
//     SizedBox(height: 16.0),
//     TextField(controller: titleController, decoration: InputDecoration(labelText: "Task Title*")),
//     SizedBox(height: 8.0),
//     ListTile(
//     title: Text(selectedTime == null ? "Reminder Time*" : selectedTime!.format(context)),
//     trailing: Icon(Icons.access_time),
//     onTap: _pickTime,
//     ),
//     SizedBox(height: 8.0),
//     if (!isOneTime && !isDaily) // Show these fields only for Custom reminders
//     ListTile(
//     title: Text(startDate == null ? "Starts On*" : DateFormat('yyyy-MM-dd').format(startDate!)),
//     trailing: Icon(Icons.calendar_today),
//     onTap: _pickStartDate,
//     ),
//     SizedBox(height: 8.0),
//     TextField(controller: noteController, decoration: InputDecoration(labelText: "Note (optional)")),
//     SizedBox(height: 8.0),
//     if (!isOneTime && !isDaily) // Show these fields only for Custom reminders
//     Row(
//     children: [
//     Text("Task never ends"),
//     Switch(
//     value: taskNeverEnds,
//     onChanged: (value) {
//     setState(() {
//     taskNeverEnds = value;
//     });
//     },
//     ),
//     ],
//     ),
//     if (!isOneTime && !isDaily && !taskNeverEnds) // Show End Date only when "Task Never Ends" is off
//     ListTile(
//     title: Text(endDate == null ? "Ends On" : DateFormat('yyyy-MM-dd').format(endDate!)),
//     trailing: Icon(Icons.calendar_today),
//     onTap: _pickEndDate,
//     ),
//     SizedBox(height: 16.0),
//     Row(
//     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//     children);