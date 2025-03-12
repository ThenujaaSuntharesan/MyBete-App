import 'package:flutter/material.dart';
import 'package:mybete_app/log_in_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'components/color.dart';
import 'donot_have_diabetes/donot_have_diabete.dart';
import 'have_diabetes/have_diabete_quiz.dart';
import 'not_sure/not_sure.dart';

class DiabeteOptions extends StatelessWidget {
  const DiabeteOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Diabetes Options"),
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle, size: 30),
            onPressed: () {
              _showLogoutMenu(context);
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          BouncingCircles(),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    prefs.setBool("onboarding", false);
                  },
                  child: Text("Choose one option from these three"),
                ),
                SizedBox(height: 20),
                userFriendlyButton(
                  context,
                  "I have diabetes",
                  Colors.red,
                  Icons.favorite,
                  HaveDiabetesDashboard(),
                ),
                SizedBox(height: 20),
                userFriendlyButton(
                  context,
                  "I don't have diabetes",
                  Colors.green,
                  Icons.no_food,
                  DonotHaveDiabeteDashboard(),
                ),
                SizedBox(height: 20),
                userFriendlyButton(
                  context,
                  "Need Guidance",
                  Colors.amber,
                  Icons.help,
                  NotSureDashboard(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showLogoutMenu(BuildContext context) {
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(1000, 80, 0, 0),
      items: [
        PopupMenuItem(
          child: ListTile(
            leading: Icon(Icons.logout),
            title: Text('Log Out'),
            onTap: () async {
              final prefs = await SharedPreferences.getInstance();
              await prefs.setBool('isLoggedIn', false);
              await prefs.remove('lastLoginDate');
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
                (route) => false,
              );
            },
          ),
        ),
      ],
    );
  }
}

Widget userFriendlyButton(BuildContext context, String text, Color color,
    IconData icon, Widget nextPage) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => nextPage),
      );
    },
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: color,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(0, 4),
            blurRadius: 10,
          ),
        ],
      ),
      width: 220,
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white),
          SizedBox(width: 10),
          Text(
            text,
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ],
      ),
    ),
  );
}

class BouncingCircles extends StatefulWidget {
  @override
  _BouncingCirclesState createState() => _BouncingCirclesState();
}

class _BouncingCirclesState extends State<BouncingCircles>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  List<Offset> positions = [Offset(0, 0), Offset(100, 100), Offset(200, 200)];
  List<Offset> directions = [Offset(2, 2), Offset(-2, 2), Offset(2, -2)];
  List<double> sizes = [50, 75, 100];
  late List<Size> screenSize;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )
      ..addListener(() {
        setState(() {
          for (int i = 0; i < positions.length; i++) {
            positions[i] += directions[i];

            if (positions[i].dx <= 0 ||
                positions[i].dx >= screenSize[i].width - sizes[i]) {
              directions[i] = Offset(-directions[i].dx, directions[i].dy);
            }
            if (positions[i].dy <= 0 ||
                positions[i].dy >= screenSize[i].height - sizes[i]) {
              directions[i] = Offset(directions[i].dx, -directions[i].dy);
            }
          }
        });
      })
      ..repeat();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    screenSize = [
      MediaQuery.of(context).size,
      MediaQuery.of(context).size,
      MediaQuery.of(context).size,
    ];

    return Stack(
      children: positions
          .asMap()
          .entries
          .map((entry) => Positioned(
                left: entry.value.dx,
                top: entry.value.dy,
                child: Container(
                  width: sizes[entry.key],
                  height: sizes[entry.key],
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                ),
              ))
          .toList(),
    );
  }
}
