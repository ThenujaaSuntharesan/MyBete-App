import 'package:flutter/material.dart';

class Symptom8Screen extends StatefulWidget {
  @override
  _SkinChangesCheckerState createState() => _SkinChangesCheckerState();
}

class _SkinChangesCheckerState extends State<Symptom8Screen> {
  List<String> _selectedSkinChanges = [];
  final List<Map<String, String>> _skinChangesOptions = [
    {'name': 'Blisters', 'image': 'assets/images/blisters.png'},
    {'name': 'Brown Patches (Dermopathy)', 'image': 'assets/images/dermopathy.png'},
    {'name': 'Thick, Waxy Skin', 'image': 'assets/images/waxy_skin.png'},
    {'name': 'Red Shiny Patches (NLD)', 'image': 'assets/images/nld.png'},
    {'name': 'Dark Velvety Skin (AN)', 'image': 'assets/images/an.png'},
    {'name': 'Firm Yellow Bumps', 'image': 'assets/images/yellow_bumps.png'},
    {'name': 'White Patches (Vitiligo)', 'image': 'assets/images/vitiligo.png'},
    {'name': 'Other', 'image': 'assets/images/other.png'},
  ];
  List<Map<String, dynamic>> _report = [];

  void _saveReport() {
    final now = DateTime.now();
    final Map<String, dynamic> entry = {
      'date': now.toString(),
      'skinChanges': List<String>.from(_selectedSkinChanges),
    };
    setState(() {
      _report.add(entry);
      _selectedSkinChanges.clear();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Skin changes saved successfully!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Skin Changes Checker',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Identify Your Symptoms:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.teal,
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Two columns
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemCount: _skinChangesOptions.length,
                itemBuilder: (context, index) {
                  final option = _skinChangesOptions[index];
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (_selectedSkinChanges.contains(option['name']!)) {
                          _selectedSkinChanges.remove(option['name']!);
                        } else {
                          _selectedSkinChanges.add(option['name']!);
                        }
                      });
                    },
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      color: _selectedSkinChanges.contains(option['name']!)
                          ? Colors.teal.shade100
                          : Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            option['image']!,
                            height: 60,
                            width: 60,
                          ),
                          SizedBox(height: 8),
                          Text(
                            option['name']!,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.teal.shade900,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 15),
            Center(
              child: ElevatedButton.icon(
                onPressed: _selectedSkinChanges.isNotEmpty ? _saveReport : null,
                icon: Icon(Icons.save),
                label: Text('Save Report'),
                style: ElevatedButton.styleFrom(
                  // primary: Colors.teal,
                  // onPrimary: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            Divider(height: 30, thickness: 2, color: Colors.teal.shade200),
            Text(
              'Saved Reports:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.teal,
              ),
            ),
            Expanded(
              child: _report.isEmpty
                  ? Center(
                child: Text(
                  'No reports saved yet.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade600,
                  ),
                ),
              )
                  : ListView.builder(
                itemCount: _report.length,
                itemBuilder: (context, index) {
                  final entry = _report[index];
                  return ListTile(
                    leading: Icon(Icons.calendar_today, color: Colors.teal),
                    title: Text(
                      'Date: ${entry['date']}',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    subtitle: Text(
                      'Skin Changes: ${entry['skinChanges'].join(', ')}',
                      style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
