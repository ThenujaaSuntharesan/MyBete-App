// // import 'package:flutter/material.dart';
// //
// // class HaveDiabeteDashboard extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text("Diabetes Dashboard"),
// //         leading: IconButton(
// //           icon: Icon(Icons.arrow_back), // Back arrow icon
// //           onPressed: () {
// //             Navigator.pop(context); // Navigate back to the previous screen
// //           },
// //         ),
// //       ),
// //       body: Center(
// //         child: Text("Welcome to the Diabetes Dashboard"),
// //       ),
// //     );
// //   }
// // }
//
//
//
// // import 'package:flutter/material.dart';
// //
// // class HaveDiabeteDashboard extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       debugShowCheckedModeBanner: false,
// //       home: QuizScreen(),
// //     );
// //   }
// // }
// //
// // class QuizScreen extends StatefulWidget {
// //   @override
// //   _QuizScreenState createState() => _QuizScreenState();
// // }
// //
// // class _QuizScreenState extends State<QuizScreen> {
// //   int _currentQuestionIndex = 0;
// //   List<String?> _selectedAnswers = List.filled(6, null);
// //
// //   final List<Map<String, dynamic>> _questions = [
// //     {'question': 'What type of diabetes do you have?', 'options': ['Type 1', 'Type 2', 'Pre diabetes']},
// //     {'question': 'When were you first diagnosed with diabetes?', 'options': ['Less than 6 months ago', 'Less than 1 year ago', '1-5 years ago', 'Over 5 years ago']},
// //     {'question': 'How often do you check your blood sugar levels?', 'options': ['Once a day', 'Twice a day', 'More than twice a day', 'Using a CGM', "I don't measure my blood sugar"]},
// //     {'question': 'What devices do you use to manage your blood sugar?', 'options': ['Basic blood glucose meter', 'Connected blood glucose meter(with an app)', 'CGM', 'Insulin pump', 'None']},
// //     {'question': 'Are you taking medication to manage diabetes?', 'options': ['Oral medication', 'Insulin', 'None']},
// //     {'question': 'Are you taking medication to manage diabetes?', 'options': ['Oral medication', 'Insulin', 'None']},
// //   ];
// //
// //   void _selectAnswer(String answer) {
// //     setState(() {
// //       _selectedAnswers[_currentQuestionIndex] = answer;
// //       if (_currentQuestionIndex < _questions.length - 1) {
// //         Future.delayed(Duration(milliseconds: 300), () {
// //           setState(() {
// //             _currentQuestionIndex++;
// //           });
// //         });
// //       }
// //     });
// //   }
// //
// //   void _goBack() {
// //     if (_currentQuestionIndex > 0) {
// //       setState(() {
// //         _currentQuestionIndex--;
// //       });
// //     }
// //   }
// //
// //   void _finishQuiz() {
// //     Navigator.pushReplacement(
// //       context,
// //       MaterialPageRoute(builder: (context) => DashboardScreen()),
// //     );
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: Text("Quiz ${_currentQuestionIndex + 1}")),
// //       body: Padding(
// //         padding: const EdgeInsets.all(16.0),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.stretch,
// //           children: [
// //             Row(
// //               mainAxisAlignment: MainAxisAlignment.center,
// //               children: List.generate(_questions.length, (index) {
// //                 return Container(
// //                   margin: EdgeInsets.symmetric(horizontal: 4),
// //                   width: 10,
// //                   height: 10,
// //                   decoration: BoxDecoration(
// //                     color: index == _currentQuestionIndex
// //                         ? Colors.blueAccent
// //                         : _selectedAnswers[index] != null
// //                         ? Colors.blue
// //                         : Colors.grey,
// //                     shape: BoxShape.circle,
// //                   ),
// //                 );
// //               }),
// //             ),
// //             SizedBox(height: 20),
// //             Text(
// //               _questions[_currentQuestionIndex]['question'],
// //               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
// //             ),
// //             SizedBox(height: 20),
// //             ...(_questions[_currentQuestionIndex]['options'] as List<String>).map((option) {
// //               return Padding(
// //                 padding: const EdgeInsets.symmetric(vertical: 8.0),
// //                 child: ElevatedButton(
// //                   style: ElevatedButton.styleFrom(
// //                     backgroundColor: _selectedAnswers[_currentQuestionIndex] == option
// //                         ? Color(0xFF7AC5CD)
// //                         : Colors.grey[300],
// //                   ),
// //                   onPressed: () => _selectAnswer(option),
// //                   child: Text(option, style: TextStyle(color: Colors.black)),
// //                 ),
// //               );
// //             }).toList(),
// //             Spacer(),
// //             Row(
// //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //               children: [
// //                 if (_currentQuestionIndex > 0)
// //                   ElevatedButton(
// //                     onPressed: _goBack,
// //                     child: Text("Back"),
// //                   ),
// //                 if (_currentQuestionIndex == _questions.length - 1)
// //                   ElevatedButton(
// //                     onPressed: _finishQuiz,
// //                     child: Text("Finish"),
// //                   ),
// //               ],
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
// //
// // class DashboardScreen extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //         appBar: AppBar(title: Text("Dashboard")),
// //         body: Center(child: Text("Welcome to the Dashboard")),
// //         bottomNavigationBar: BottomNavigationBar(
// //             items: [
// //               BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
// //               BottomNavigationBarItem(icon: Icon(Icons.analytics), label: "Stats"),
// //               BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
// //               BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
// //             ],
// //             ),
// //         );
// //     }
// // }
//
//
// import 'package:flutter/material.dart';
//
//
// class HaveDiabeteDashboard extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: QuizScreen(),
//     );
//   }
// }
//
// class QuizScreen extends StatefulWidget {
//   @override
//   _QuizScreenState createState() => _QuizScreenState();
// }
//
// class _QuizScreenState extends State<QuizScreen> {
//   int _currentQuestionIndex = 0;
//   List<String?> _selectedAnswers = List.filled(6, null);
//
//   final List<Map<String, dynamic>> _questions = [
//     {
//       'question': 'What type of diabetes do you have?',
//       'options': ['Type 1', 'Type 2', 'Pre diabetes']
//     },
//     {
//       'question': 'When were you first diagnosed with diabetes?',
//       'options': [
//         'Less than 6 months ago',
//         'Less than 1 year ago',
//         '1-5 years ago',
//         'Over 5 years ago'
//       ]
//     },
//     {
//       'question': 'How often do you check your blood sugar levels?',
//       'options': [
//         'Once a day',
//         'Twice a day',
//         'More than twice a day',
//         'Using a CGM',
//         "I don't measure my blood sugar"
//       ]
//     },
//     {
//       'question': 'What devices do you use to manage your blood sugar?',
//       'options': [
//         'Basic blood glucose meter',
//         'Connected blood glucose meter (with an app)',
//         'CGM',
//         'Insulin pump',
//         'None'
//       ]
//     },
//     {
//       'question': 'Are you taking medication to manage diabetes?',
//       'options': ['Oral medication', 'Insulin', 'None']
//     },
//     {
//       'question': 'Are you taking medication to manage diabetes?',
//       'options': ['Oral medication', 'Insulin', 'None']
//     },
//   ];
//
//   void _selectAnswer(String answer) {
//     setState(() {
//       _selectedAnswers[_currentQuestionIndex] = answer;
//     });
//   }
//
//   void _goToNextQuestion() {
//     if (_currentQuestionIndex < _questions.length - 1) {
//       setState(() {
//         _currentQuestionIndex++;
//       });
//     }
//   }
//
//   void _goBack() {
//     if (_currentQuestionIndex > 0) {
//       setState(() {
//         _currentQuestionIndex--;
//       });
//     }
//   }
//
//   void _finishQuiz() {
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (context) => DashboardScreen()),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     bool isLastQuestion = _currentQuestionIndex == _questions.length - 1;
//     bool hasSelectedAnswer = _selectedAnswers[_currentQuestionIndex] != null;
//
//     return Scaffold(
//       appBar: AppBar(title: Text("Question ${_currentQuestionIndex + 1}")),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: List.generate(_questions.length, (index) {
//                 return Container(
//                   margin: EdgeInsets.symmetric(horizontal: 4),
//                   width: 10,
//                   height: 10,
//                   decoration: BoxDecoration(
//                     color: index == _currentQuestionIndex
//                         ? Colors.blueAccent
//                         : _selectedAnswers[index] != null
//                         ? Colors.blue
//                         : Colors.grey,
//                     shape: BoxShape.circle,
//                   ),
//                 );
//               }),
//             ),
//             SizedBox(height: 20),
//             Text(
//               _questions[_currentQuestionIndex]['question'],
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 20),
//             ...(_questions[_currentQuestionIndex]['options'] as List<String>)
//                 .map((option) {
//               return Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 8.0),
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor:
//                     _selectedAnswers[_currentQuestionIndex] == option
//                         ? Color(0xFF7AC5CD)
//                         : Colors.grey[300],
//                   ),
//                   onPressed: () => _selectAnswer(option),
//                   child: Text(option, style: TextStyle(color: Colors.black)),
//                 ),
//               );
//             }).toList(),
//             Spacer(),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 if (_currentQuestionIndex > 0)
//                   ElevatedButton(
//                     onPressed: _goBack,
//                     child: Text("Back"),
//                   ),
//                 if (hasSelectedAnswer)
//                   ElevatedButton(
//                     onPressed:
//                     isLastQuestion ? _finishQuiz : _goToNextQuestion,
//                     child: Text(isLastQuestion ? "Finish" : "Next"),
//                   ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class DashboardScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Dashboard")),
//       body: Center(child: Text("Welcome to the Dashboard")),
//       bottomNavigationBar: BottomNavigationBar(
//         items: [
//           BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
//           BottomNavigationBarItem(icon: Icon(Icons.analytics), label: "Stats"),
//           BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
//           BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
//         ],
//       ),
//     );
//   }
// }






// import 'package:flutter/material.dart';
//
//
// class HaveDiabeteDashboard extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: QuizScreen(),
//     );
//   }
// }
//
// class QuizScreen extends StatefulWidget {
//   @override
//   _QuizScreenState createState() => _QuizScreenState();
// }
//
// class _QuizScreenState extends State<QuizScreen> {
//   int _currentQuestionIndex = 0;
//   List<String?> _selectedAnswers = List.filled(6, null);
//
//   final List<Map<String, dynamic>> _questions = [
//     {
//       'question': 'What type of diabetes do you have?',
//       'options': ['Type 1', 'Type 2', 'Pre diabetes']
//     },
//     {
//       'question': 'When were you first diagnosed with diabetes?',
//       'options': [
//         'Less than 6 months ago',
//         'Less than 1 year ago',
//         '1-5 years ago',
//         'Over 5 years ago'
//       ]
//     },
//     {
//       'question': 'How often do you check your blood sugar levels?',
//       'options': [
//         'Once a day',
//         'Twice a day',
//         'More than twice a day',
//         'Using a CGM',
//         "I don't measure my blood sugar"
//       ]
//     },
//     {
//       'question': 'What devices do you use to manage your blood sugar?',
//       'options': [
//         'Basic blood glucose meter',
//         'Connected blood glucose meter (with an app)',
//         'CGM',
//         'Insulin pump',
//         'None'
//       ]
//     },
//     {
//       'question': 'Are you taking medication to manage diabetes?',
//       'options': ['Oral medication', 'Insulin', 'None']
//     },
//     {
//       'question': 'Are you taking medication to manage diabetes?',
//       'options': ['Oral medication', 'Insulin', 'None']
//     },
//   ];
//
//   void _selectAnswer(String answer) {
//     setState(() {
//       _selectedAnswers[_currentQuestionIndex] = answer;
//     });
//   }
//
//   void _goToNextQuestion() {
//     if (_currentQuestionIndex < _questions.length - 1) {
//       setState(() {
//         _currentQuestionIndex++;
//       });
//     }
//   }
//
//   void _goBack() {
//     if (_currentQuestionIndex > 0) {
//       setState(() {
//         _currentQuestionIndex--;
//       });
//     }
//   }
//
//   void _finishQuiz() {
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (context) => DashboardScreen()),
//     );
//   }
//
//   bool get _allQuestionsAnswered => _selectedAnswers.every((answer) => answer != null);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Question ${_currentQuestionIndex + 1}")),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: List.generate(_questions.length, (index) {
//                 return Container(
//                   margin: EdgeInsets.symmetric(horizontal: 4),
//                   width: 10,
//                   height: 10,
//                   decoration: BoxDecoration(
//                     color: index == _currentQuestionIndex
//                         ? Colors.blueAccent
//                         : _selectedAnswers[index] != null
//                         ? Colors.blue
//                         : Colors.grey,
//                     shape: BoxShape.circle,
//                   ),
//                 );
//               }),
//             ),
//             SizedBox(height: 20),
//             Text(
//               _questions[_currentQuestionIndex]['question'],
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 20),
//             ...(_questions[_currentQuestionIndex]['options'] as List<String>)
//                 .map((option) {
//               return Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 8.0),
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor:
//                     _selectedAnswers[_currentQuestionIndex] == option
//                         ? Color(0xFF7AC5CD)
//                         : Colors.grey[300],
//                   ),
//                   onPressed: () => _selectAnswer(option),
//                   child: Text(option, style: TextStyle(color: Colors.black)),
//                 ),
//               );
//             }).toList(),
//             Spacer(),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 if (_currentQuestionIndex > 0)
//                   ElevatedButton(
//                     onPressed: _goBack,
//                     child: Text("Back"),
//                   ),
//                 if (_allQuestionsAnswered)
//                   ElevatedButton(
//                     onPressed: _finishQuiz,
//                     child: Text("Finish"),
//                   ),
//                 if (_selectedAnswers[_currentQuestionIndex] != null && _currentQuestionIndex < _questions.length - 1)
//                   ElevatedButton(
//                     onPressed: _goToNextQuestion,
//                     child: Text("Next"),
//                   ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class DashboardScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Dashboard")),
//       body: Center(child: Text("Welcome to the Dashboard")),
//       bottomNavigationBar: BottomNavigationBar(
//         items: [
//           BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
//           BottomNavigationBarItem(icon: Icon(Icons.analytics), label: "Stats"),
//           BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
//           BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
//         ],
//       ),
//     );
//   }
// }






// import 'package:flutter/material.dart';
//
// class HaveDiabeteDashboard extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: QuizScreen(),
//     );
//   }
// }
//
// class QuizScreen extends StatefulWidget {
//   @override
//   _QuizScreenState createState() => _QuizScreenState();
// }
//
// class _QuizScreenState extends State<QuizScreen> {
//   int _currentQuestionIndex = 0;
//   List<String?> _selectedAnswers = List.filled(6, null);
//
//   final List<Map<String, dynamic>> _questions = [
//     {
//       'question': 'What type of diabetes do you have?',
//       'options': ['Type 1', 'Type 2', 'Pre diabetes']
//     },
//     {
//       'question': 'When were you first diagnosed with diabetes?',
//       'options': [
//         'Less than 6 months ago',
//         'Less than 1 year ago',
//         '1-5 years ago',
//         'Over 5 years ago'
//       ]
//     },
//     {
//       'question': 'How often do you check your blood sugar levels?',
//       'options': [
//         'Once a day',
//         'Twice a day',
//         'More than twice a day',
//         'Using a CGM',
//         "I don't measure my blood sugar"
//       ]
//     },
//     {
//       'question': 'What devices do you use to manage your blood sugar?',
//       'options': [
//         'Basic blood glucose meter',
//         'Connected blood glucose meter (with an app)',
//         'CGM',
//         'Insulin pump',
//         'None'
//       ]
//     },
//     {
//       'question': 'Are you taking medication to manage diabetes?',
//       'options': ['Oral medication', 'Insulin', 'None']
//     },
//     {
//       'question': 'Are you taking medication to manage diabetes?',
//       'options': ['Oral medication', 'Insulin', 'None']
//     },
//   ];
//
//   void _selectAnswer(String answer) {
//     setState(() {
//       _selectedAnswers[_currentQuestionIndex] = answer;
//     });
//   }
//
//   void _goToNextQuestion() {
//     if (_currentQuestionIndex < _questions.length - 1) {
//       setState(() {
//         _currentQuestionIndex++;
//       });
//     }
//   }
//
//   void _goBack(BuildContext context) {
//     if (_currentQuestionIndex == 0) {
//       Navigator.pop(context); // Go back to the previous page (e.g., option page)
//     } else {
//       setState(() {
//         _currentQuestionIndex--;
//       });
//     }
//   }
//
//   void _finishQuiz() {
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (context) => DashboardScreen()),
//     );
//   }
//
//   bool get _allQuestionsAnswered =>
//       _selectedAnswers.every((answer) => answer != null);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           onPressed: () => _goBack(context),
//         ),
//         title: Text("Question ${_currentQuestionIndex + 1}"),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: List.generate(_questions.length, (index) {
//                 return Container(
//                   margin: EdgeInsets.symmetric(horizontal: 4),
//                   width: 10,
//                   height: 10,
//                   decoration: BoxDecoration(
//                     color: index == _currentQuestionIndex
//                         ? Colors.blueAccent
//                         : _selectedAnswers[index] != null
//                         ? Colors.blue
//                         : Colors.grey,
//                     shape: BoxShape.circle,
//                   ),
//                 );
//               }),
//             ),
//             SizedBox(height: 20),
//             Text(
//               _questions[_currentQuestionIndex]['question'],
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 20),
//             ...(_questions[_currentQuestionIndex]['options'] as List<String>)
//                 .map((option) {
//               return Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 8.0),
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor:
//                     _selectedAnswers[_currentQuestionIndex] == option
//                         ? Color(0xFF7AC5CD)
//                         : Colors.grey[300],
//                   ),
//                   onPressed: () => _selectAnswer(option),
//                   child: Text(option, style: TextStyle(color: Colors.black)),
//                 ),
//               );
//             }).toList(),
//             Spacer(),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 ElevatedButton(
//                   onPressed: () => _goBack(context),
//                   child: Text("Back"),
//                 ),
//                 if (_selectedAnswers[_currentQuestionIndex] != null &&
//                     _currentQuestionIndex < _questions.length - 1)
//                   ElevatedButton(
//                     onPressed: _goToNextQuestion,
//                     child: Text("Next"),
//                   ),
//                 if (_allQuestionsAnswered &&
//                     _currentQuestionIndex == _questions.length - 1)
//                   ElevatedButton(
//                     onPressed: _finishQuiz,
//                     child: Text("Finish"),
//                   ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class DashboardScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Dashboard")),
//       body: Center(child: Text("Welcome to the Dashboard")),
//       bottomNavigationBar: BottomNavigationBar(
//         items: [
//           BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
//           BottomNavigationBarItem(icon: Icon(Icons.analytics), label: "Stats"),
//           BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
//           BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
//         ],
//       ),
//     );
//   }
// }







//
// import 'package:flutter/material.dart';
//
// class HaveDiabeteDashboard extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: QuizScreen(),
//     );
//   }
// }
//
// class QuizScreen extends StatefulWidget {
//   @override
//   _QuizScreenState createState() => _QuizScreenState();
// }
//
// class _QuizScreenState extends State<QuizScreen> {
//   int _currentQuestionIndex = 0;
//   List<String?> _selectedAnswers = List.filled(6, null);
//
//   final List<Map<String, dynamic>> _questions = [
//     {
//       'question': 'What type of diabetes do you have?',
//       'options': ['Type 1', 'Type 2', 'Pre diabetes']
//     },
//     {
//       'question': 'When were you first diagnosed with diabetes?',
//       'options': [
//         'Less than 6 months ago',
//         'Less than 1 year ago',
//         '1-5 years ago',
//         'Over 5 years ago'
//       ]
//     },
//     {
//       'question': 'How often do you check your blood sugar levels?',
//       'options': [
//         'Once a day',
//         'Twice a day',
//         'More than twice a day',
//         'Using a CGM',
//         "I don't measure my blood sugar"
//       ]
//     },
//     {
//       'question': 'What devices do you use to manage your blood sugar?',
//       'options': [
//         'Basic blood glucose meter',
//         'Connected blood glucose meter (with an app)',
//         'CGM',
//         'Insulin pump',
//         'None'
//       ]
//     },
//     {
//       'question': 'Are you taking medication to manage diabetes?',
//       'options': ['Oral medication', 'Insulin', 'None']
//     },
//     {
//       'question': 'Are you taking medication to manage diabetes?',
//       'options': ['Oral medication', 'Insulin', 'None']
//     },
//   ];
//
//   void _selectAnswer(String answer) {
//     setState(() {
//       _selectedAnswers[_currentQuestionIndex] = answer;
//     });
//   }
//
//   void _goToNextQuestion() {
//     if (_currentQuestionIndex < _questions.length - 1) {
//       setState(() {
//         _currentQuestionIndex++;
//       });
//     }
//   }
//
//   void _goBack(BuildContext context) {
//     if (_currentQuestionIndex == 0) {
//       Navigator.pop(context); // Go back to the previous page (e.g., option page)
//     } else {
//       setState(() {
//         _currentQuestionIndex--;
//       });
//     }
//   }
//
//   void _finishQuiz() {
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (context) => DashboardScreen()),
//     );
//   }
//
//   bool get _allQuestionsAnswered =>
//       _selectedAnswers.every((answer) => answer != null);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           onPressed: () => _goBack(context),
//         ),
//         title: Text("Question ${_currentQuestionIndex + 1}"),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: List.generate(_questions.length, (index) {
//                 return Container(
//                   margin: EdgeInsets.symmetric(horizontal: 4),
//                   width: 10,
//                   height: 10,
//                   decoration: BoxDecoration(
//                     color: index == _currentQuestionIndex
//                         ? Colors.blueAccent
//                         : _selectedAnswers[index] != null
//                         ? Colors.blue
//                         : Colors.grey,
//                     shape: BoxShape.circle,
//                   ),
//                 );
//               }),
//             ),
//             SizedBox(height: 20),
//             Text(
//               _questions[_currentQuestionIndex]['question'],
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 20),
//             ...(_questions[_currentQuestionIndex]['options'] as List<String>)
//                 .map((option) {
//               return Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 8.0),
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor:
//                     _selectedAnswers[_currentQuestionIndex] == option
//                         ? Color(0xFF7AC5CD)
//                         : Colors.grey[300],
//                   ),
//                   onPressed: () => _selectAnswer(option),
//                   child: Text(option, style: TextStyle(color: Colors.black)),
//                 ),
//               );
//             }).toList(),
//             Spacer(),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 ElevatedButton(
//                   onPressed: () => _goBack(context),
//                   child: Text("Back"),
//                 ),
//                 if (_selectedAnswers[_currentQuestionIndex] != null &&
//                     _currentQuestionIndex < _questions.length - 1)
//                   ElevatedButton(
//                     onPressed: _goToNextQuestion,
//                     child: Text("Next"),
//                   ),
//                 if (_allQuestionsAnswered &&
//                     _currentQuestionIndex == _questions.length - 1)
//                   ElevatedButton(
//                     onPressed: _finishQuiz,
//                     child: Text("Finish"),
//                   ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class DashboardScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Dashboard")),
//       body: Center(child: Text("Welcome to the Dashboard")),
//       bottomNavigationBar: BottomNavigationBar(
//         items: [
//           BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
//           BottomNavigationBarItem(icon: Icon(Icons.analytics), label: "Stats"),
//           BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
//           BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import '../diabete_options.dart';
import 'DashBoard/MyActivity.dart';

class HaveDiabetesDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: QuizScreen(),
    );
  }
}

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentQuestionIndex = 0;
  List<String?> _selectedAnswers = List.filled(5, null);

  final List<Map<String, dynamic>> _questions = [
    {
      'question': 'What type of diabetes do you have?',
      'options': ['Type 1', 'Type 2', 'Pre diabetes']
    },
    {
      'question': 'When were you first diagnosed with diabetes?',
      'options': [
        'Less than 6 months ago',
        'Less than 1 year ago',
        '1-5 years ago',
        'Over 5 years ago'
      ]
    },
    {
      'question': 'How often do you check your blood sugar levels?',
      'options': [
        'Once a day',
        'Twice a day',
        'More than twice a day',
        'Using a CGM',
        "I don't measure my blood sugar"
      ]
    },
    {
      'question': 'What devices do you use to manage your blood sugar?',
      'options': [
        'Basic blood glucose meter',
        'Connected blood glucose meter (with an app)',
        'CGM',
        'Insulin pump',
        'None'
      ]
    },
    {
      'question': 'Are you taking medication to manage diabetes?',
      'options': ['Oral medication', 'Insulin', 'None']
    },
  ];

  void _selectAnswer(String answer) {
    setState(() {
      _selectedAnswers[_currentQuestionIndex] = answer;
    });
  }

  void _goToNextQuestion() {
    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
      });
    }
  }

  void _goBack(BuildContext context) {
    if (_currentQuestionIndex == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => DiabeteOptions()),
      );
    } else {
      setState(() {
        _currentQuestionIndex--;
      });
    }
  }

  void _finishQuiz() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => DashboardScreen()),
    );
  }

  bool get _allQuestionsAnswered =>
      _selectedAnswers.every((answer) => answer != null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => _goBack(context),
        ),
        title: Text("Question ${_currentQuestionIndex + 1}"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Progress Indicator Dots
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(_questions.length, (index) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 4),
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: index == _currentQuestionIndex
                        ? Colors.blueAccent
                        : _selectedAnswers[index] != null
                        ? Colors.blue
                        : Colors.grey,
                    shape: BoxShape.circle,
                  ),
                );
              }),
            ),
            SizedBox(height: 20),

            // Question Text
            Text(
              _questions[_currentQuestionIndex]['question'],
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),

            // Answer Buttons
            ...(_questions[_currentQuestionIndex]['options'] as List<String>)
                .map((option) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                    _selectedAnswers[_currentQuestionIndex] == option
                        ? Color(0xFF7AC5CD)
                        : Colors.grey[300],
                  ),
                  onPressed: () => _selectAnswer(option),
                  child: Text(option, style: TextStyle(color: Colors.black)),
                ),
              );
            }).toList(),
            Spacer(),

            // Navigation Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () => _goBack(context),
                  child: Text("Back"),
                ),

                if (_selectedAnswers[_currentQuestionIndex] != null &&
                    _currentQuestionIndex < _questions.length - 1)
                  ElevatedButton(
                    onPressed: _goToNextQuestion,
                    child: Text("Next"),
                  ),

                if (_allQuestionsAnswered &&
                    _currentQuestionIndex == _questions.length - 1)
                  Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                      onPressed: _finishQuiz,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                      child: Text("Finish"),
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
//
// class DashboardScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Dashboard")),
//       body: Center(child: Text("Welcome to the Dashboard")),
//       bottomNavigationBar: BottomNavigationBar(
//         items: [
//           BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
//           BottomNavigationBarItem(icon: Icon(Icons.analytics), label: "Stats"),
//           BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
//           BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
//         ],
//       ),
//     );
//   }
// }









