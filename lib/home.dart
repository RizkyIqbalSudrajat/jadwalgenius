import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CalendarTablePage extends StatefulWidget {
  @override
  _CalendarTablePageState createState() => _CalendarTablePageState();
}

class _CalendarTablePageState extends State<CalendarTablePage> {
  DateTime _selectedDate = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.week;
  TextEditingController _eventController = TextEditingController();
  Map<DateTime, List<dynamic>> _events = {};

  @override
  void initState() {
    super.initState();
    _calendarFormat = CalendarFormat.week; // Set initial format to week
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
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
            focusedDay: _selectedDate, // Use _selectedDate as the focusedDay
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
                _selectedDate = selectedDate; // Update _selectedDate here
              });
            },
            eventLoader: _getEventsForDay,
            headerStyle: HeaderStyle(
              formatButtonVisible: false,
              formatButtonShowsNext: false,
            ),
            locale: 'id_ID',
          ),
          // ListView untuk menampilkan event
          Expanded(
            child: _events[_selectedDate]?.isEmpty ?? true
                ? Center(
                    child: Text(
                      'Tidak ada event untuk tanggal ini.',
                      style: TextStyle(fontSize: 18.0),
                    ),
                  )
                : ListView.builder(
                    itemCount: _events[_selectedDate]?.length ?? 0,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          title: Text(_events[_selectedDate]?[index]),
                          // Add more content as needed
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Tambahkan Event'),
                content: TextField(
                  controller: _eventController,
                  decoration: InputDecoration(
                    labelText: 'Event',
                    hintText: 'Masukkan detail event',
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () async {
                      if (_eventController.text.isEmpty) return;
                      await saveEventToFirestore(
                          _selectedDate, _eventController.text);
                      setState(() {
                        _events[_selectedDate] = _events[_selectedDate] ?? [];
                        _events[_selectedDate]?.add(_eventController.text);
                        _eventController.clear();
                        Navigator.of(context).pop();
                      });
                    },
                    child: Text('Simpan'),
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
        tooltip: 'Tambahkan Event',
      ),
    );
  }

  List<dynamic> _getEventsForDay(DateTime day) {
    return _events[day] ?? [];
  }

  Future<void> saveEventToFirestore(DateTime date, String event) async {
    try {
      await FirebaseFirestore.instance.collection('event').doc().set({
        'date': date,
        'event': event,
      });
      print('Event saved to Firestore');
    } catch (e) {
      print('Error saving event: $e');
    }
  }
}
