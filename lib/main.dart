// ignore_for_file: unused_field

import 'dart:io';

import 'package:EduPlan/home.dart';
import 'package:EduPlan/introduction_animation/introduction_animation_screen.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize();
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
      home: const IntroductionAnimationScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  final _pageOptions = [
    LMSHomePage(),
    WebView(
    initialUrl: 'https://flutter.dev',
    onWebViewCreated: (WebViewController webViewController) {
      // You can use the WebViewController to interact with the WebView
    },
  ),
    // Tambahkan halaman-halaman lain di sini
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,

        title: Text('Helo Sobat EduPlan',
            style: GoogleFonts.poppins(color: Colors.white)),
        backgroundColor: const Color(0xffEEC143),
        shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom:
                Radius.circular(30), // Mengatur border radius untuk melengkung
          ),
        ),
        toolbarHeight: 50, // Mengubah tinggi AppBar

      ),
      body: <Widget>[
        LMSHomePage(),
      ][_selectedIndex], // Set the body based on the selected index
    );
  }
}
