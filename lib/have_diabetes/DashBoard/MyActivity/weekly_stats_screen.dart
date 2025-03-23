// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:intl/intl.dart';
// import 'dart:math';
//
// import 'bi_weekly_stats_screen.dart';
//
// class WeeklyStatsScreen extends StatefulWidget {
//   final List<Map<String, dynamic>> logEntries;
//   final Color primaryColor;
//   final Color accentColor;
//   final Color lightColor;
//   final Color veryLightColor;
//   final Color tealColor;
//   final Color textColor;
//
//   const WeeklyStatsScreen({
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
//   _WeeklyStatsScreenState createState() => _WeeklyStatsScreenState();
// }
//
// class _WeeklyStatsScreenState extends State<WeeklyStatsScreen> {
//   late DateTime _startDate;
//   late DateTime _endDate;
//   double _weeklyAverage = 0;
//   int _totalLogs = 0;
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
//       'previous': false,
//     };
//   }
//
//   // Calculate the date range for the current week
//   void _calculateDateRange() {
//     final now = DateTime.now();
//     // Start from Sunday of the current week
//     _startDate = now.subtract(Duration(days: now.weekday % 7));
//     // End on Saturday of the current week
//     _endDate = _startDate.add(const Duration(days: 6));
//   }
//
//   // Process log data for the current week
//   void _processData() {
//     // Filter entries for the current week
//     final weekEntries = widget.logEntries.where((entry) {
//       final date = (entry['date'] as Timestamp).toDate();
//       return date.isAfter(_startDate.subtract(const Duration(days: 1))) &&
//           date.isBefore(_endDate.add(const Duration(days: 1))) &&
//           entry['bloodSugar'] != null;
//     }).toList();
//
//     // Calculate weekly average
//     double sum = 0;
//     for (var entry in weekEntries) {
//       sum += entry['bloodSugar'];
//     }
//     _weeklyAverage = weekEntries.isNotEmpty ? sum / weekEntries.length : 0;
//     _totalLogs = weekEntries.length;
//   }
//
//   // Navigate to bi-weekly stats
//   void _navigateToBiWeeklyStats() {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => BiWeeklyStatsScreen(
//           logEntries: widget.logEntries,
//           primaryColor: widget.primaryColor,
//           accentColor: widget.accentColor,
//           lightColor: widget.lightColor,
//           veryLightColor: widget.veryLightColor,
//           tealColor: widget.tealColor,
//           textColor: widget.textColor,
//         ),
//       ),
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
//   // Build collapsible week section
//   Widget _buildWeekSection(String title, bool isExpanded, VoidCallback onToggle) {
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
//                   'Weekly blood sugar chart will be displayed here',
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
//                     // Weekly stats header with arrow
//                     Center(
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 Text(
//                                   'Weekly Stats',
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
//                               Icons.arrow_forward_ios,
//                               size: 20,
//                               color: widget.accentColor,
//                             ),
//                             onPressed: _navigateToBiWeeklyStats,
//                           ),
//                         ],
//                       ),
//                     ),
//
//                     const SizedBox(height: 24),
//
//                     // Weekly average
//                     _buildAverageCircle(_weeklyAverage),
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
//                     // Week sections
//                     _buildWeekSection(
//                         'Mar 3 - 9, 2025 | Week 10',
//                         _expandedSections['current'] ?? false,
//                             () => setState(() => _expandedSections['current'] = !(_expandedSections['current'] ?? false))
//                     ),
//
//                     _buildWeekSection(
//                         'Feb 17 - 23, 2025 | Week 8',
//                         _expandedSections['previous'] ?? false,
//                             () => setState(() => _expandedSections['previous'] = !(_expandedSections['previous'] ?? false))
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
import 'bi_weekly_stats_screen.dart';

class WeeklyStatsScreen extends StatefulWidget {
  final List<Map<String, dynamic>> logEntries;
  final Color primaryColor;
  final Color accentColor;
  final Color lightColor;
  final Color veryLightColor;
  final Color tealColor;
  final Color textColor;

  const WeeklyStatsScreen({
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
  State<WeeklyStatsScreen> createState() => _WeeklyStatsScreenState();
}

class _WeeklyStatsScreenState extends State<WeeklyStatsScreen> {
  // Current week data
  String currentWeek = '';
  int totalLogs = 0;
  double averageBloodSugar = 0.0;

  // Weekly data points
  List<FlSpot> weeklySpots = [];
  List<String> weekDays = [];

  // Previous week data
  String previousWeek = '';

  // Expanded sections
  bool _isCurrentWeekExpanded = true;
  bool _isPreviousWeekExpanded = false;

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
        weeklySpots = [];
      });
      return;
    }

    // Get current date and calculate week start/end
    final now = DateTime.now();
    final weekStart = now.subtract(Duration(days: now.weekday - 1));
    final weekEnd = weekStart.add(const Duration(days: 6));

    // Format current week string
    currentWeek = 'Mar ${weekStart.day} - ${weekEnd.day}, ${weekStart.year} | Week ${(weekStart.difference(DateTime(weekStart.year, 1, 1)).inDays / 7).ceil() + 1}';

    // Calculate previous week
    final prevWeekStart = weekStart.subtract(const Duration(days: 7));
    final prevWeekEnd = prevWeekStart.add(const Duration(days: 6));
    previousWeek = 'Feb ${prevWeekStart.day} - ${prevWeekEnd.day}, ${prevWeekStart.year} | Week ${(prevWeekStart.difference(DateTime(prevWeekStart.year, 1, 1)).inDays / 7).ceil() + 1}';

    // Filter logs for current week
    final weekLogs = widget.logEntries.where((log) {
      final logDate = log['date'] is Timestamp
          ? (log['date'] as Timestamp).toDate()
          : DateTime.parse(log['date'].toString());
      return logDate.isAfter(weekStart.subtract(const Duration(days: 1))) &&
          logDate.isBefore(weekEnd.add(const Duration(days: 1)));
    }).toList();

    // Calculate total logs and average blood sugar
    totalLogs = weekLogs.length;

    double totalBloodSugar = 0;
    int bloodSugarCount = 0;

    // Initialize spots for each day of the week
    weeklySpots = List.generate(7, (index) => FlSpot(index.toDouble(), 0));
    weekDays = List.generate(7, (index) {
      final day = weekStart.add(Duration(days: index));
      return DateFormat('dd/MM').format(day);
    });

    // Process each log
    for (var log in weekLogs) {
      if (log['bloodSugar'] != null) {
        final bloodSugar = double.parse(log['bloodSugar'].toString());
        totalBloodSugar += bloodSugar;
        bloodSugarCount++;

        // Add to chart data
        final logDate = log['date'] is Timestamp
            ? (log['date'] as Timestamp).toDate()
            : DateTime.parse(log['date'].toString());
        final dayIndex = logDate.difference(weekStart).inDays;
        if (dayIndex >= 0 && dayIndex < 7) {
          weeklySpots[dayIndex] = FlSpot(dayIndex.toDouble(), bloodSugar);
        }
      }
    }

    // Calculate average
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

          // Weekly Stats section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Center(
                        child: Text(
                          'Weekly Stats',
                          style: TextStyle(
                            fontFamily: GoogleFonts.poppins().fontFamily,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: widget.textColor,
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.arrow_forward_ios, size: 18),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BiWeeklyStatsScreen(
                              logEntries: widget.logEntries,
                              primaryColor: widget.primaryColor,
                              accentColor: widget.accentColor,
                              lightColor: widget.lightColor,
                              veryLightColor: widget.veryLightColor,
                              tealColor: widget.tealColor,
                              textColor: widget.textColor,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                Text(
                  '3-9 Mar',
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
                  // Week header with toggle
                  InkWell(
                    onTap: () {
                      setState(() {
                        _isCurrentWeekExpanded = !_isCurrentWeekExpanded;
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
                            currentWeek,
                            style: TextStyle(
                              fontFamily: GoogleFonts.poppins().fontFamily,
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Icon(
                            _isCurrentWeekExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Line chart (collapsible)
                  if (_isCurrentWeekExpanded)
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
                                  if (value.toInt() >= 0 && value.toInt() < weekDays.length) {
                                    return Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Text(
                                        weekDays[value.toInt()],
                                        style: TextStyle(
                                          fontFamily: GoogleFonts.poppins().fontFamily,
                                          color: widget.textColor.withAlpha(150),
                                          fontSize: 10,
                                        ),
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
                                reservedSize: 40,
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
                          maxX: 6,
                          minY: 0,
                          maxY: 240,
                          lineBarsData: [
                            LineChartBarData(
                              spots: weeklySpots.where((spot) => spot.y > 0).toList(),
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

                  // Previous week section with toggle
                  InkWell(
                    onTap: () {
                      setState(() {
                        _isPreviousWeekExpanded = !_isPreviousWeekExpanded;
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
                            previousWeek,
                            style: TextStyle(
                              fontFamily: GoogleFonts.poppins().fontFamily,
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Icon(
                            _isPreviousWeekExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Previous week content (collapsible)
                  if (_isPreviousWeekExpanded)
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Center(
                        child: Text(
                          'Weekly blood sugar chart will be displayed here',
                          style: TextStyle(
                            fontFamily: GoogleFonts.poppins().fontFamily,
                            color: Colors.grey,
                            fontSize: 14,
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

