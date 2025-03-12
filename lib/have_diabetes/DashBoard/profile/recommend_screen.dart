import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class RecommendScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Share.share(
      "I'm using the myBete App to manage diabetes. Try it out! Download here: https://mybete.com/app",
    );

    // Close the screen after sharing
    Future.delayed(Duration(milliseconds: 200), () {
      Navigator.of(context).pop();
    });

    return SizedBox.shrink(); // Empty widget since UI isn't needed
  }
}





