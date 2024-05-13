// ignore_for_file: unused_field

import 'package:EduPlan/home.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  final _pageOptions = [
    LMSHomePage(),
    // Tambahkan halaman-halaman lain di sini
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Helo Sobat EduPlan',
            style: GoogleFonts.poppins(color: Colors.white)),
        backgroundColor: Color(0xffEEC143),
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom:
                Radius.circular(30), // Mengatur border radius untuk melengkung
          ),
        ),
        toolbarHeight: 50, // Mengubah tinggi AppBar

        actions: [
          IconButton(
            icon: Icon(Icons.account_circle, color: Colors.white,),
            onPressed: () {
              // Tambahkan logika untuk menangani ketika avatar ditekan
            },
          ),
        ],
      ),
      body: <Widget>[
        LMSHomePage(),
      ][_selectedIndex], // Set the body based on the selected index
      bottomNavigationBar: CurvedNavigationBar(
        color: Color(0xffEEC143),
        animationDuration: const Duration(milliseconds: 400),
        backgroundColor: Colors.transparent,
        height: 50,
        items: [
          CurvedNavigationBarItem(
            child: const Icon(
              Icons.home_outlined,
              color: Colors.white,
            ),
            labelStyle: GoogleFonts.poppins(color: Colors.white),
          )
        ],
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
