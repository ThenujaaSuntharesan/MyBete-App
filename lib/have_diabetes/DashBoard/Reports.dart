import 'package:flutter/material.dart';

class ReportsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Reports"),
          backgroundColor: Color(0xFF5FB8DD),
        ),
        body: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Upload Your Report",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xFF5EB7CF)),
                    borderRadius: BorderRadius.circular(8),
                    color: Color(0xFFC5EDFF),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.cloud_upload, size: 50, color: Color(0xFF5EB7CF)),
                      SizedBox(height: 10),
                      Text("Browse Files to Upload"),
                      SizedBox(height: 10),
                      ElevatedButton.icon(
                        icon: Icon(Icons.file_upload),
                        label: Text("Select File"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF5EB7CF),
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
            ),
        );
    }
}