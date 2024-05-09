import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:jadwalgenius/home.dart';

void main() {
  initializeDateFormatting(
      'id_ID', null); // Inisialisasi format tanggal untuk bahasa Indonesia
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false, // Menghapus debug banner
      home: CalendarTablePage(),
    );
  }
}




