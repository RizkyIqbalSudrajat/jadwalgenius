import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jadwalgenius/detail.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<Task> _tasks;
  late List<DateTime> _days;
  late int _todayIndex;
  late String _todayDate;

  @override
  void initState() {
    super.initState();
    _tasks = _getTasks();
    _days = _getDays();
    _todayIndex = _getTodayIndex();
    _todayDate = _getTodayDate();
  }

  List<Task> _getTasks() {
    return List.generate(
        10,
        (index) =>
            Task('Task ${index + 1}', 'Description of task ${index + 1}'));
  }

  List<DateTime> _getDays() {
    List<DateTime> days = [];
    DateTime now = DateTime.now();
    // Mendapatkan hari ini
    int today = now.weekday;
    // Mendapatkan tanggal Senin dari minggu ini
    DateTime monday = now.subtract(Duration(days: today - 1));
    for (int i = 0; i < 7; i++) {
      days.add(monday.add(Duration(days: i)));
    }
    return days;
  }

  int _getTodayIndex() {
    DateTime now = DateTime.now();
    int todayIndex = _days.indexWhere((date) =>
        date.year == now.year &&
        date.month == now.month &&
        date.day == now.day);
    return todayIndex;
  }

  String _getTodayDate() {
    DateTime now = DateTime.now();
    return DateFormat.yMMMMEEEEd('id_ID').format(now);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Row(
          children: [
            Expanded(child: Text(_todayDate)),
            CircleAvatar(
              backgroundColor: Colors.white,
              child:
                  Icon(Icons.person), // Icon yang akan ditampilkan pada avatar
            ),
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 100, // Tinggi kalender
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _days.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    color: index == _todayIndex
                        ? Colors.red
                        : Colors
                            .blueAccent, // Warna merah untuk hari ini, warna biru untuk hari lainnya
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        DateFormat.yMMMMEEEEd('id_ID').format(_days[
                            index]), // Format tanggal ke dalam bahasa Indonesia
                        style:
                            const TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          // Daftar tugas
          Expanded(
            child: ListView.builder(
              itemCount: _tasks.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              TaskDetailPage(task: _tasks[index])),
                    );
                  },
                  child: Card(
                    elevation:
                        3, // Elevasi kartu untuk memberikan efek bayangan
                    margin: EdgeInsets.symmetric(
                        vertical: 8, horizontal: 16), // Margin kartu
                    child: ListTile(
                      title: Text(
                        _tasks[index].name,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(_tasks[index].description),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}