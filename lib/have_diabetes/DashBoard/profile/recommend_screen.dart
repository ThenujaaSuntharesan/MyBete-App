// import 'package:flutter/material.dart';
// import 'package:share_plus/share_plus.dart';
//
// class RecommendScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     Share.share(
//       "I'm using the myBete App to manage diabetes. Try it out! Download here: https://mybete.com/app",
//     );
//
//     // Close the screen after sharing
//     Future.delayed(Duration(milliseconds: 200), () {
//       Navigator.of(context).pop();
//     });
//
//     return SizedBox.shrink(); // Empty widget since UI isn't needed
//   }
// }
//
//
//
//
//



// import 'package:flutter/material.dart';
// import 'package:share_plus/share_plus.dart';
//
// class RecommendScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // Instead of automatically sharing and closing, let's show a proper UI first
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: Colors.black),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: Text(
//           "Recommend myBete",
//           style: TextStyle(color: Colors.black, fontSize: 20),
//         ),
//         backgroundColor: Color(0xFF89D0ED),
//         elevation: 0,
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Icon(
//               Icons.share_outlined,
//               size: 80,
//               color: Color(0xFF89D0ED),
//             ),
//             SizedBox(height: 24),
//             Text(
//               "Share myBete with your friends",
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             SizedBox(height: 16),
//             Text(
//               "Help others manage their diabetes by recommending the myBete app.",
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 fontSize: 16,
//                 color: Colors.grey[600],
//               ),
//             ),
//             SizedBox(height: 32),
//             ElevatedButton(
//               onPressed: () {
//                 Share.share(
//                   "I'm using the myBete App to manage diabetes. Try it out! Download here: https://mybete.com/app",
//                 );
//               },
//               child: Padding(
//                 padding: EdgeInsets.symmetric(vertical: 12),
//                 child: Text(
//                   "Share Now",
//                   style: TextStyle(fontSize: 16),
//                 ),
//               ),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Color(0xFF89D0ED),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }





import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class RecommendScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Recommend myBete",
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
        backgroundColor: Color(0xFF89D0ED),
        elevation: 0,
      ),
      body: Container(
        color: Color(0xFFF0F9FD),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.share,
                size: 80,
                color: Color(0xFF89D0ED),
              ),
              SizedBox(height: 20),
              Text(
                "Share myBete with your friends",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  "Help others manage their diabetes by recommending the myBete app",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey[600],
                  ),
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  _shareApp(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF89D0ED),
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
                child: Text("Share Now"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _shareApp(BuildContext context) async {
    await Share.share(
      "I'm using the myBete App to manage diabetes. Try it out! Download here: https://mybete.com/app",
    );
  }
}