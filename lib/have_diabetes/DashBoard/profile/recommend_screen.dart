// import 'package:flutter/material.dart';
// import 'package:share/share.dart';
//
// class RecommendScreen extends StatelessWidget {
//   final String appLink = "https://mybete.com"; // Replace with actual app link
//
//   void shareApp(String method) {
//     Share.share("Check out myBete App: $appLink");
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Recommend myBete")),
//       body: ListView(
//         children: [
//           ListTile(
//             leading: Icon(Icons.whatsapp, color: Colors.green),
//             title: Text("Share via WhatsApp"),
//             onTap: () => shareApp("whatsapp"),
//           ),
//           ListTile(
//             leading: Icon(Icons.camera, color: Colors.purple),
//             title: Text("Share via Instagram"),
//             onTap: () => shareApp("instagram"),
//           ),
//           ListTile(
//             leading: Icon(Icons.email, color: Colors.blue),
//             title: Text("Share via Email"),
//             onTap: () => shareApp("email"),
//           ),
//           ListTile(
//             leading: Icon(Icons.copy_all, color: Colors.grey),
//             title: Text("Copy Link"),
//             onTap: () {
//               Share.share("Check out myBete: $appLink");
//             },
//           ),
//         ],
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
      appBar: AppBar(title: Text('Recommend myBete')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Share.share(
              "I'm using the myBete App to manage diabetes. Try it out! Download here: https://mybete.com/app",
              subject: "Try myBete App!",
            );
          },
          child: Text("Share via"),
        ),
      ),
    );
  }
}
