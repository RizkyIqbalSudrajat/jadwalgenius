import 'package:EduPlan/Agama/screen.dart';
import 'package:EduPlan/BhsIndonesia/screen.dart';
import 'package:EduPlan/BhsInggris/screen.dart';
import 'package:EduPlan/Biologi/screen.dart';
import 'package:EduPlan/Fisika/screen.dart';
import 'package:EduPlan/Matematika/screen.dart';
import 'package:EduPlan/Olahraga/screen.dart';
import 'package:EduPlan/PKN/screen.dart';
import 'package:EduPlan/kelas7.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';

class LMSHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<String> images = [
      'assets/mapel/1.jpg',
      'assets/mapel/2.jpg',
      'assets/mapel/3.jpg',
    ]; // Ganti URL dengan URL gambar Anda
    List<Map<String, dynamic>> subjects = [
      {
        'name': 'PKN',
        'icon': Icons.account_balance,
        'color': Colors.red, // Tambahkan properti warna untuk PKN
        'screen': pknscreen(), // Tambahkan layar yang sesuai
      },
      {
        'name': 'Bahasa Inggris',
        'icon': Icons.language,
        'color': Colors.blue, // Tambahkan properti warna untuk Bahasa Inggris
        'screen': bhsinggris(), // Tambahkan layar yang sesuai
      },
      {
        'name': 'Matematika',
        'icon': Icons.calculate,
        'color': Colors.green, // Tambahkan properti warna untuk Matematika
        'screen': Matematika(), // Tambahkan layar yang sesuai
      },
      {
        'name': 'Bahasa Indonesia',
        'icon': Icons.book,
        'color':
            Colors.orange, // Tambahkan properti warna untuk Bahasa Indonesia
        'screen': BahasaIndonesia(), // Tambahkan layar yang sesuai
      },
      {
        'name': 'Fisika',
        'icon': Icons.science,
        'color': Colors.purple, // Tambahkan properti warna untuk Fisika
        'screen': Fisika(), // Tambahkan layar yang sesuai
      },
      {
        'name': 'Biologi',
        'icon': Icons.biotech,
        'color': Colors.teal, // Tambahkan properti warna untuk Biologi
        'screen': Biologi(), // Tambahkan layar yang sesuai
      },
      {
        'name': 'Agama',
        'icon': Icons.star,
        'color': Colors.amber, // Tambahkan properti warna untuk Agama
        'screen': Agama(), // Tambahkan layar yang sesuai
      },
      {
        'name': 'Olahraga',
        'icon': Icons.sports_soccer,
        'color': Colors.indigo, // Tambahkan properti warna untuk Olahraga
        'screen': Olahraga(), // Tambahkan layar yang sesuai
      },
    ];

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CarouselSlider(
                options: CarouselOptions(
                  height: 200.0,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  aspectRatio: 16 / 9,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enableInfiniteScroll: true,
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  viewportFraction: 0.8,
                ),
                items: images.map((image) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          image: DecorationImage(
                            image: AssetImage(image),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'Mau belajar apa hari ini sobat EduPlan?',
                style: GoogleFonts.poppins(fontSize: 15.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: GridView.count(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 3,
                  crossAxisSpacing: 7.0,
                  mainAxisSpacing: 7.0,
                  padding: EdgeInsets.all(10.0),
                  children: subjects.map((subject) {
                    return GestureDetector(
                      onTap: () {
                        // Navigasi ke halaman kursus yang sesuai
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => subject['screen']),
                        );
                      },
                      child: Card(
                        elevation: 5.0,
                        color: subject['color'],
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(subject['icon'],
                                size: 37.0, color: Colors.white),
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  subject['name'],
                                  style: GoogleFonts.poppins(
                                      fontSize: 10.0, color: Colors.white),
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.clip,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
