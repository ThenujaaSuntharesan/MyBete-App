// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:intl/intl.dart';
// import 'dart:math';
//
// class MonthlyStatsScreen extends StatefulWidget {
//   final List<Map<String, dynamic>> logEntries;
//   final Color primaryColor;
//   final Color accentColor;
//   final Color lightColor;
//   final Color veryLightColor;
//   final Color tealColor;
//   final Color textColor;
//
//   const MonthlyStatsScreen({
//     Key? key,
//     required this.logEntries,
//     required this.primaryColor,
//     required this.accentColor,
//     required this.lightColor,
//     required this.veryLightColor,
//     required this.tealColor,
//     required this.textColor,
//   }) : super(key: key);
//
//   @override
//   _MonthlyStatsScreenState createState() => _MonthlyStatsScreenState();
// }
//
// class _MonthlyStatsScreenState extends State<MonthlyStatsScreen> {
//   late DateTime _startDate;
//   late DateTime _endDate;
//   double _monthlyAverage = 0;
//   int _totalLogs = 0;
//   int _selectedMonth = DateTime.now().month;
//   int _selectedYear = DateTime.now().year;
//   Map<String, bool> _expandedSections = {};
//
//   @override
//   void initState() {
//     super.initState();
//     _calculateDateRange();
//     _processData();
//
//     // Initialize expanded sections
//     _expandedSections = {
//       'current': true,
//     };
//   }
//
//   // Calculate the date range for the current month
//   void _calculateDateRange() {
//     _startDate = DateTime(_selectedYear, _selectedMonth, 1);
//     // End on the last day of the month
//     _endDate = DateTime(_selectedYear, _selectedMonth + 1, 0);
//   }
//
//   // Process log data for the current month
//   void _processData() {
//     // Filter entries for the current month
//     final monthEntries = widget.logEntries.where((entry) {
//       final date = (entry['date'] as Timestamp).toDate();
//       return date.isAfter(_startDate.subtract(const Duration(days: 1))) &&
//           date.isBefore(_endDate.add(const Duration(days: 1))) &&
//           entry['bloodSugar'] != null;
//     }).toList();
//
//     // Calculate monthly average
//     double sum = 0;
//     for (var entry in monthEntries) {
//       sum += entry['bloodSugar'];
//     }
//     _monthlyAverage = monthEntries.isNotEmpty ? sum / monthEntries.length : 0;
//     _totalLogs = monthEntries.length;
//   }
//
//   // Change month
//   void _changeMonth(int month, int year) {
//     setState(() {
//       _selectedMonth = month;
//       _selectedYear = year;
//       _calculateDateRange();
//       _processData();
//     });
//   }
//
//   // Show month picker
//   void _showMonthPicker() {
//     showModalBottomSheet(
//       context: context,
//       backgroundColor: Colors.white,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       builder: (BuildContext context) {
//         return Container(
//           height: 300,
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   TextButton(
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                     child: Text(
//                       'Cancel',
//                       style: TextStyle(
//                         fontFamily: GoogleFonts.poppins().fontFamily,
//                         color: widget.accentColor,
//                       ),
//                     ),
//                   ),
//                   Text(
//                     'Select Month',
//                     style: TextStyle(
//                       fontFamily: GoogleFonts.poppins().fontFamily,
//                       fontSize: 18,
//                       fontWeight: FontWeight.w600,
//                       color: widget.textColor,
//                     ),
//                   ),
//                   TextButton(
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                     child: Text(
//                       'Done',
//                       style: TextStyle(
//                         fontFamily: GoogleFonts.poppins().fontFamily,
//                         fontWeight: FontWeight.w600,
//                         color: widget.accentColor,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 16),
//               Expanded(
//                 child: GridView.builder(
//                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 3,
//                     childAspectRatio: 2,
//                   ),
//                   itemCount: 12,
//                   itemBuilder: (context, index) {
//                     final month = index + 1;
//                     final isSelected = month == _selectedMonth;
//                     return InkWell(
//                       onTap: () {
//                         _changeMonth(month, _selectedYear);
//                         Navigator.pop(context);
//                       },
//                       child: Container(
//                         margin: const EdgeInsets.all(4),
//                         decoration: BoxDecoration(
//                           color: isSelected ? widget.accentColor : widget.lightColor.withAlpha(76),
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         child: Center(
//                           child: Text(
//                             DateFormat('MMM').format(DateTime(2022, month)),
//                             style: TextStyle(
//                               fontFamily: GoogleFonts.poppins().fontFamily,
//                               fontSize: 16,
//                               fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
//                               color: isSelected ? Colors.white : widget.textColor,
//                             ),
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   // Build the average circle
//   Widget _buildAverageCircle(double average) {
//     return Container(
//       width: 120,
//       height: 120,
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         color: widget.lightColor,
//         border: Border.all(
//           color: widget.accentColor.withAlpha(76),
//           width: 2,
//         ),
//       ),
//       child: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               average > 0 ? average.toStringAsFixed(1) : '---',
//               style: TextStyle(
//                 fontFamily: GoogleFonts.poppins().fontFamily,
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//                 color: widget.textColor,
//               ),
//             ),
//             Text(
//               'mg/dL',
//               style: TextStyle(
//                 fontFamily: GoogleFonts.poppins().fontFamily,
//                 fontSize: 14,
//                 color: widget.textColor.withAlpha(179),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   // Build collapsible month section
//   Widget _buildMonthSection(String title, bool isExpanded, VoidCallback onToggle) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 8),
//       decoration: BoxDecoration(
//         color: widget.lightColor.withAlpha(100),
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Column(
//         children: [
//           InkWell(
//             onTap: onToggle,
//             child: Padding(
//               padding: const EdgeInsets.all(12),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     title,
//                     style: TextStyle(
//                       fontFamily: GoogleFonts.poppins().fontFamily,
//                       fontSize: 16,
//                       fontWeight: FontWeight.w500,
//                       color: widget.textColor,
//                     ),
//                   ),
//                   Icon(
//                     isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
//                     color: widget.accentColor,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           if (isExpanded)
//             Container(
//               height: 200,
//               padding: const EdgeInsets.all(16),
//               child: Center(
//                 child: Text(
//                   'Monthly blood sugar chart will be displayed here',
//                   style: TextStyle(
//                     fontFamily: GoogleFonts.poppins().fontFamily,
//                     fontSize: 14,
//                     color: widget.textColor.withAlpha(179),
//                   ),
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
//
//   // Get formatted date range for display
//   String _getFormattedDateRange() {
//     final dateFormat = DateFormat('d MMM');
//     return '${dateFormat.format(_startDate)} - ${dateFormat.format(_endDate)}';
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: widget.primaryColor,
//         title: const Text(
//           'Stats',
//           style: TextStyle(
//             fontSize: 20,
//             fontWeight: FontWeight.w600,
//             color: Colors.black87,
//           ),
//           textAlign: TextAlign.center,
//         ),
//         centerTitle: true,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.black87),
//           onPressed: () => Navigator.of(context).pop(),
//         ),
//         elevation: 0,
//       ),
//       body: Column(
//         children: [
//           // Total logs
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//             decoration: BoxDecoration(
//               color: widget.primaryColor,
//               border: Border(
//                 bottom: BorderSide(color: Colors.grey.withAlpha(51)),
//               ),
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   'Total logs',
//                   style: TextStyle(
//                     fontFamily: GoogleFonts.poppins().fontFamily,
//                     fontSize: 16,
//                     fontWeight: FontWeight.w500,
//                     color: Colors.black87,
//                   ),
//                 ),
//                 Text(
//                   _totalLogs.toString(),
//                   style: TextStyle(
//                     fontFamily: GoogleFonts.poppins().fontFamily,
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                     color: Colors.black87,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//
//           Expanded(
//             child: SingleChildScrollView(
//               child: Padding(
//                 padding: const EdgeInsets.all(16),
//                 child: Column(
//                   children: [
//                     // Monthly stats header with calendar icon
//                     Center(
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 Text(
//                                   'Monthly Stats',
//                                   style: TextStyle(
//                                     fontFamily: GoogleFonts.poppins().fontFamily,
//                                     fontSize: 20,
//                                     fontWeight: FontWeight.w600,
//                                     color: widget.textColor,
//                                   ),
//                                   textAlign: TextAlign.center,
//                                 ),
//                                 Text(
//                                   _getFormattedDateRange(),
//                                   style: TextStyle(
//                                     fontFamily: GoogleFonts.poppins().fontFamily,
//                                     fontSize: 14,
//                                     color: widget.textColor.withAlpha(179),
//                                   ),
//                                   textAlign: TextAlign.center,
//                                 ),
//                               ],
//                             ),
//                           ),
//                           IconButton(
//                             icon: Icon(
//                               Icons.calendar_today,
//                               size: 20,
//                               color: widget.accentColor,
//                             ),
//                             onPressed: _showMonthPicker,
//                           ),
//                         ],
//                       ),
//                     ),
//
//                     const SizedBox(height: 24),
//
//                     // Monthly average
//                     _buildAverageCircle(_monthlyAverage),
//                     const SizedBox(height: 8),
//                     Text(
//                       'Average',
//                       style: TextStyle(
//                         fontFamily: GoogleFonts.poppins().fontFamily,
//                         fontSize: 14,
//                         color: widget.textColor.withAlpha(179),
//                       ),
//                     ),
//
//                     const SizedBox(height: 32),
//
//                     // Month section
//                     _buildMonthSection(
//                         'February 2025',
//                         _expandedSections['current'] ?? false,
//                             () => setState(() => _expandedSections['current'] = !(_expandedSections['current'] ?? false))
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MonthlyStatsScreen extends StatefulWidget {
  final List<Map<String, dynamic>> logEntries;
  final Color primaryColor;
  final Color accentColor;
  final Color lightColor;
  final Color veryLightColor;
  final Color tealColor;
  final Color textColor;

  const MonthlyStatsScreen({
    Key? key,
    required this.logEntries,
    required this.primaryColor,
    required this.accentColor,
    required this.lightColor,
    required this.veryLightColor,
    required this.tealColor,
    required this.textColor,
  }) : super(key: key);

  @override
  State<MonthlyStatsScreen> createState() => _MonthlyStatsScreenState();
}

class _MonthlyStatsScreenState extends State<MonthlyStatsScreen> {
  // Current month data
  String currentMonth = '';
  String dateRange = '';
  int totalLogs = 0;
  double averageBloodSugar = 0.0;

  // Monthly data points
  List<FlSpot> monthlySpots = [];
  List<String> weekLabels = ['1', '2', '3', '4'];

  // Expanded sections
  bool _isCurrentMonthExpanded = true;

  @override
  void initState() {
    super.initState();
    _processLogData();
  }

  void _processLogData() {
    if (widget.logEntries.isEmpty) {
      setState(() {
        totalLogs = 0;
        averageBloodSugar = 0.0;
        monthlySpots = [];
      });
      return;
    }

    // Get current date and calculate month start/end
    final now = DateTime.now();
    final monthStart = DateTime(now.year, now.month, 1);
    final monthEnd = DateTime(now.year, now.month + 1, 0);

    // Format current month string
    currentMonth = DateFormat('MMMM yyyy').format(monthStart);
    dateRange = '${monthStart.day} ${DateFormat('MMM').format(monthStart)} - ${monthEnd.day} ${DateFormat('MMM').format(monthEnd)}';

    // Filter logs for current month
    final monthLogs = widget.logEntries.where((log) {
      final logDate = log['date'] is Timestamp
          ? (log['date'] as Timestamp).toDate()
          : DateTime.parse(log['date'].toString());
      return logDate.isAfter(monthStart.subtract(const Duration(days: 1))) &&
          logDate.isBefore(monthEnd.add(const Duration(days: 1)));
    }).toList();

    // Calculate total logs and average blood sugar
    totalLogs = monthLogs.length;

    double totalBloodSugar = 0;
    int bloodSugarCount = 0;

    // Group logs by week of month
    Map<int, List<Map<String, dynamic>>> weeklyLogs = {
      0: [], // Week 1
      1: [], // Week 2
      2: [], // Week 3
      3: [], // Week 4
    };

    // Process each log
    for (var log in monthLogs) {
      if (log['bloodSugar'] != null) {
        final bloodSugar = double.parse(log['bloodSugar'].toString());
        totalBloodSugar += bloodSugar;
        bloodSugarCount++;

        // Add to weekly groups
        final logDate = log['date'] is Timestamp
            ? (log['date'] as Timestamp).toDate()
            : DateTime.parse(log['date'].toString());
        final weekOfMonth = ((logDate.day - 1) / 7).floor();
        if (weekOfMonth < 4) {
          weeklyLogs[weekOfMonth]!.add(log);
        }
      }
    }

    // Initialize spots for each week of the month
    monthlySpots = List.generate(4, (index) => FlSpot(index.toDouble(), 0));

    // Calculate weekly averages
    for (int i = 0; i < 4; i++) {
      final weekLogs = weeklyLogs[i]!;
      if (weekLogs.isNotEmpty) {
        double weekTotal = 0;
        int weekCount = 0;

        for (var log in weekLogs) {
          if (log['bloodSugar'] != null) {
            weekTotal += double.parse(log['bloodSugar'].toString());
            weekCount++;
          }
        }

        if (weekCount > 0) {
          monthlySpots[i] = FlSpot(i.toDouble(), weekTotal / weekCount);
        }
      }
    }

    // Calculate overall average
    setState(() {
      averageBloodSugar = bloodSugarCount > 0 ? totalBloodSugar / bloodSugarCount : 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: widget.primaryColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Stats',
          style: TextStyle(
            fontFamily: GoogleFonts.poppins().fontFamily,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          // Total logs section
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: widget.lightColor,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total logs',
                  style: TextStyle(
                    fontFamily: GoogleFonts.poppins().fontFamily,
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
                Text(
                  '$totalLogs',
                  style: TextStyle(
                    fontFamily: GoogleFonts.poppins().fontFamily,
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // Monthly Stats section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Center(
                  child: Text(
                    'Monthly Stats',
                    style: TextStyle(
                      fontFamily: GoogleFonts.poppins().fontFamily,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: widget.textColor,
                    ),
                  ),
                ),
                Text(
                  dateRange,
                  style: TextStyle(
                    fontFamily: GoogleFonts.poppins().fontFamily,
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 20),

                // Average circle
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: widget.lightColor,
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          averageBloodSugar > 0 ? averageBloodSugar.toStringAsFixed(1) : '---',
                          style: TextStyle(
                            fontFamily: GoogleFonts.poppins().fontFamily,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: widget.textColor,
                          ),
                        ),
                        Text(
                          'mg/dL',
                          style: TextStyle(
                            fontFamily: GoogleFonts.poppins().fontFamily,
                            fontSize: 14,
                            color: widget.textColor.withAlpha(178),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Average',
                  style: TextStyle(
                    fontFamily: GoogleFonts.poppins().fontFamily,
                    fontSize: 16,
                    color: widget.textColor,
                  ),
                ),
              ],
            ),
          ),

          // Chart section
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Month header with toggle
                  InkWell(
                    onTap: () {
                      setState(() {
                        _isCurrentMonthExpanded = !_isCurrentMonthExpanded;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      color: widget.accentColor,
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            currentMonth,
                            style: TextStyle(
                              fontFamily: GoogleFonts.poppins().fontFamily,
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Icon(
                            _isCurrentMonthExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Line chart (collapsible)
                  if (_isCurrentMonthExpanded)
                    Container(
                      height: 300,
                      padding: const EdgeInsets.all(16.0),
                      child: LineChart(
                        LineChartData(
                          gridData: FlGridData(
                            show: true,
                            drawVerticalLine: true,
                            horizontalInterval: 80,
                            verticalInterval: 1,
                            getDrawingHorizontalLine: (value) {
                              if (value == 160) { // High glucose level
                                return FlLine(
                                  color: Colors.red.withAlpha(100),
                                  strokeWidth: 1,
                                );
                              } else if (value == 80) { // Low glucose level
                                return FlLine(
                                  color: Colors.blue.withAlpha(100),
                                  strokeWidth: 1,
                                );
                              }
                              return FlLine(
                                color: Colors.grey.withAlpha(30),
                                strokeWidth: 0.5,
                              );
                            },
                            getDrawingVerticalLine: (value) {
                              return FlLine(
                                color: Colors.grey.withAlpha(30),
                                strokeWidth: 0.5,
                              );
                            },
                          ),
                          titlesData: FlTitlesData(
                            show: true,
                            rightTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            topTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                reservedSize: 30,
                                interval: 1,
                                getTitlesWidget: (value, meta) {
                                  if (value.toInt() >= 0 && value.toInt() < weekLabels.length) {
                                    return Text(
                                      'Week ${weekLabels[value.toInt()]}',
                                      style: TextStyle(
                                        fontFamily: GoogleFonts.poppins().fontFamily,
                                        color: widget.textColor.withAlpha(150),
                                        fontSize: 10,
                                      ),
                                    );
                                  }
                                  return Text('');
                                },
                              ),
                            ),
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                interval: 80,
                                reservedSize: 40,
                                getTitlesWidget: (value, meta) {
                                  if (value % 80 == 0 && value > 0) {
                                    return Text(
                                      '${value.toInt()}',
                                      style: TextStyle(
                                        fontFamily: GoogleFonts.poppins().fontFamily,
                                        color: widget.textColor.withAlpha(150),
                                        fontSize: 10,
                                      ),
                                    );
                                  }
                                  return Text('');
                                },
                              ),
                            ),
                          ),
                          borderData: FlBorderData(
                            show: true,
                            border: Border(
                              bottom: BorderSide(color: Colors.grey.withAlpha(50)),
                              left: BorderSide(color: Colors.grey.withAlpha(50)),
                            ),
                          ),
                          minX: 0,
                          maxX: 3,
                          minY: 0,
                          maxY: 240,
                          lineBarsData: [
                            LineChartBarData(
                              spots: monthlySpots.where((spot) => spot.y > 0).toList(),
                              isCurved: true,
                              color: widget.tealColor,
                              barWidth: 2,
                              isStrokeCapRound: true,
                              dotData: FlDotData(
                                show: true,
                                getDotPainter: (spot, percent, barData, index) {
                                  return FlDotCirclePainter(
                                    radius: 5,
                                    color: widget.tealColor,
                                    strokeWidth: 2,
                                    strokeColor: Colors.white,
                                  );
                                },
                              ),
                              belowBarData: BarAreaData(
                                show: true,
                                color: widget.tealColor.withAlpha(30),
                              ),
                            ),
                          ],
                          lineTouchData: LineTouchData(
                            touchTooltipData: LineTouchTooltipData(
                              getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
                                return touchedBarSpots.map((barSpot) {
                                  return LineTooltipItem(
                                    '${barSpot.y.toInt()} mg/dL',
                                    TextStyle(
                                      fontFamily: GoogleFonts.poppins().fontFamily,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  );
                                }).toList();
                              },
                            ),
                          ),
                        ),
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
}


