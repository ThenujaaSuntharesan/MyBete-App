import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:mybete_app/have_diabetes/DashBoard/profile/account_settings_screen.dart';
import 'package:mybete_app/have_diabetes/DashBoard/profile/recommend_screen.dart';
import 'package:mybete_app/have_diabetes/DashBoard/profile/support_feedback_screen.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String email = "thenujaasuntharesan@gmail.com";
  File? _profileImage;
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Header with Profile title
          Container(
            width: double.infinity,
            color: Color(0xFF89D0ED),
            padding: EdgeInsets.only(left: 20, right: 20, top: 70, bottom: 16),
            child: Text(
              "Profile",
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),

          // Profile avatar and email
          Expanded(
            child: Container(
              width: double.infinity,
              color: Colors.white, // Changed to white background
              child: Column(
                children: [
                  SizedBox(height: 20),
                  // Profile image with border
                  GestureDetector(
                    onTap: _pickImage,
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Color(0xFFD6EDF8),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.grey.shade300, width: 1),
                        image: _profileImage != null
                            ? DecorationImage(
                          image: FileImage(_profileImage!),
                          fit: BoxFit.cover,
                        )
                            : null,
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  // Email with tap to edit
                  GestureDetector(
                    onTap: _showEmailDialog,
                    child: Text(
                      email,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

                  // Menu items
                  _buildMenuItem(
                    icon: Icons.settings_outlined,
                    title: "Account & Settings",
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AccountSettingsScreen()),
                    ),
                  ),
                  _buildMenuItem(
                    icon: Icons.bar_chart_outlined,
                    title: "Stats",
                    onTap: () {},
                  ),
                  _buildMenuItem(
                    icon: Icons.menu_book_outlined,
                    title: "User Manual",
                    onTap: () {},
                  ),
                  _buildMenuItem(
                    icon: Icons.favorite_outline,
                    title: "Recommend myBete",
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RecommendScreen()),
                    ),
                  ),
                  _buildMenuItem(
                    icon: Icons.chat_bubble_outline,
                    title: "Support & Feedback",
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SupportFeedbackScreen()),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Row(
          children: [
            Icon(icon, color: Colors.grey, size: 22),
            SizedBox(width: 15),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600, // Made text bolder
                color: Colors.black, // Darker text color
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Function to pick image from gallery
  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _profileImage = File(image.path);
      });
    }
  }

  // Function to show email edit dialog
  void _showEmailDialog() {
    TextEditingController controller = TextEditingController(text: email);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Change Email"),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(
              labelText: "Email",
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.emailAddress,
          ),
          actions: [
            TextButton(
              child: Text("Cancel"),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: Text(
                "Save",
                style: TextStyle(color: Color(0xFF89D0ED)),
              ),
              onPressed: () {
                if (controller.text.isNotEmpty && controller.text.contains('@')) {
                  setState(() {
                    email = controller.text;
                  });
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Please enter a valid email address")),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }
}