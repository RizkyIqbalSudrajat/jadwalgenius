import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarTablePage extends StatefulWidget {
  @override
  _CalendarTablePageState createState() => _CalendarTablePageState();
}

class _CalendarTablePageState extends State<CalendarTablePage> {
  DateTime _selectedDate = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.week;

  @override
  void initState() {
    super.initState();
    _calendarFormat = CalendarFormat.week; // Set initial format to week
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kalender Tabel'),
      ),
      body: Column(
        children: [
          // Header untuk tanggal yang dipilih
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              DateFormat('EEEE, d MMMM yyyy', 'id_ID').format(_selectedDate),
              style: TextStyle(fontSize: 24),
            ),
          ),
          // Tabel kalender
          TableCalendar(
            firstDay: DateTime(2021, 1, 1),
            lastDay: DateTime(2024, 12, 31),
            focusedDay:
                DateTime.now(), // Set the focusedDay to a date within the range
            calendarFormat: _calendarFormat,
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            selectedDayPredicate: (day) {
              // Use selectedDayPredicate to highlight selected date
              return isSameDay(_selectedDate, day);
            },
            onDaySelected: (selectedDate, _) {
              setState(() {
                _selectedDate = selectedDate;
              });
            },
            headerStyle: HeaderStyle(
              formatButtonVisible: false,
              formatButtonShowsNext: false,
            ),
            locale: 'id_ID',
          ),
        ],
      ),
    );
  }
}
