// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// class SupportFeedbackScreen extends StatefulWidget {
//   @override
//   _SupportFeedbackScreenState createState() => _SupportFeedbackScreenState();
// }
//
// class _SupportFeedbackScreenState extends State<SupportFeedbackScreen> {
//   final TextEditingController _messageController = TextEditingController();
//
//   void sendFeedback() async {
//     final Uri emailUri = Uri(
//       scheme: 'mailto',
//       path: 'thenujaasuntharesan@gmail.com',
//       queryParameters: {
//         'subject': 'User Feedback',
//         'body': _messageController.text,
//       },
//     );
//
//     if (await canLaunch(emailUri.toString())) {
//       await launch(emailUri.toString());
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Error sending feedback")),
//       );
//     }
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Support & Feedback")),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _messageController,
//               decoration: InputDecoration(labelText: "Enter your feedback"),
//               maxLines: 5,
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: sendFeedback,
//               child: Text("Send Feedback"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';

class SupportFeedbackScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ask Support"),
        backgroundColor: Color(0xFF5FB8DD),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(decoration: InputDecoration(hintText: "Send us a message")),
            SizedBox(height: 20),
            ElevatedButton(onPressed: () {}, child: Text("Send")),
          ],
        ),
      ),
    );
  }
}
