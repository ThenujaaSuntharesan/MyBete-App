import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class PeriodCheckerScreen extends StatefulWidget {
  @override
  _PeriodCheckerScreenState createState() => _PeriodCheckerScreenState();
}

class _PeriodCheckerScreenState extends State<PeriodCheckerScreen> {
  DateTime? startDate;
  DateTime? endDate;
  List<Map<String, DateTime>> periodDates = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Period Checker'),
      ),
      body: Column(
        children: [
          TableCalendar(
            focusedDay: DateTime.now(),
            firstDay: DateTime.utc(2000),
            lastDay: DateTime.utc(2100),
            calendarFormat: CalendarFormat.month,
            selectedDayPredicate: (day) =>
            day == startDate || day == endDate,
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                if (startDate == null || endDate != null) {
                  startDate = selectedDay;
                  endDate = null;
                } else {
                  endDate = selectedDay;
                }
              });
            },
          ),
          if (startDate != null && endDate != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                  'Selected Period: ${startDate?.toLocal()} to ${endDate?.toLocal()}'),
            ),
          ElevatedButton(
            onPressed: () {
              if (startDate != null && endDate != null) {
                setState(() {
                  periodDates.add({'start': startDate!, 'end': endDate!});
                  startDate = null;
                  endDate = null;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Period dates saved!')));
              }
            },
            child: Text('Save Period Dates'),
          ),
          ElevatedButton(
            onPressed: () {
              if (periodDates.length >= 6) {
                // Logic to analyze period data for status
                bool isNormal = true;
                for (var period in periodDates.takeLast(6)) {
                  if ((period['end']!.difference(period['start']!).inDays >
                      7) ||
                      period['start']!.difference(period['end']!).inDays > 35) {
                    isNormal = false;
                    break;
                  }
                }
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: Text('Period Status'),
                    content: Text(isNormal
                        ? 'Your periods are normal.'
                        : 'You might have some irregularities.'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(ctx).pop(),
                        child: Text('Close'),
                      ),
                    ],
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Not enough data to analyze period status.')));
              }
            },
            child: Text('Period Status'),
          ),
        ],
      ),
    );
  }
}
