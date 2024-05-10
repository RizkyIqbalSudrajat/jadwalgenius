import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jadwalgenius/PKN/detail.dart';
import 'package:jadwalgenius/kelas7.dart';

class LMSHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<String> images = [
      'https://example.com/image1.jpg',
      'https://example.com/image2.jpg',
      'https://example.com/image3.jpg',
    ]; // Ganti URL dengan URL gambar Anda
    List<Map<String, dynamic>> subjects = [
      {
        'name': 'PKN',
        'icon': Icons.account_balance,
        'color': Colors.red, // Tambahkan properti warna untuk PKN
      },
      {
        'name': 'Bahasa Inggris',
        'icon': Icons.language,
        'color': Colors.blue, // Tambahkan properti warna untuk Bahasa Inggris
      },
      {
        'name': 'Matematika',
        'icon': Icons.calculate,
        'color': Colors.green, // Tambahkan properti warna untuk Matematika
      },
      {
        'name': 'Bahasa Indonesia',
        'icon': Icons.book,
        'color':
            Colors.orange, // Tambahkan properti warna untuk Bahasa Indonesia
      },
      {
        'name': 'Fisika',
        'icon': Icons.science,
        'color': Colors.purple, // Tambahkan properti warna untuk Fisika
      },
      {
        'name': 'Biologi',
        'icon': Icons.biotech,
        'color': Colors.teal, // Tambahkan properti warna untuk Biologi
      },
      {
        'name': 'Agama',
        'icon': Icons.star,
        'color': Colors.amber, // Tambahkan properti warna untuk Agama
      },
      {
        'name': 'Olahraga',
        'icon': Icons.sports_soccer,
        'color': Colors.indigo, // Tambahkan properti warna untuk Olahraga
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
                  borderRadius:
                      BorderRadius.circular(20), // Set radius border container
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5), // Warna bayangan
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // Perubahan posisi bayangan
                    ),
                  ],
                ),
                child: GridView.count(
                  shrinkWrap: true,
                  physics:
                      NeverScrollableScrollPhysics(), // Tidak dapat digulir
                  crossAxisCount: 3,
                  crossAxisSpacing: 7.0,
                  mainAxisSpacing: 7.0,
                  padding: EdgeInsets.all(10.0),
                  children: subjects.map((subject) {
                    return GestureDetector(
                      onTap: () {
                        // Navigasi ke halaman kursus
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => CourseInfoScreen()),
                        );
                      },
                      child: Card(
                        elevation: 5.0,
                        color: subject[
                            'color'], // Set warna card sesuai dengan properti warna mata pelajaran
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(subject['icon'],
                                size: 37.0,
                                color: Colors.white), // Set warna icon
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  subject['name'],
                                  style: GoogleFonts.poppins(
                                      fontSize: 10.0,
                                      color: Colors.white), // Set warna teks
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

class CoursePage extends StatelessWidget {
  const CoursePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Courses', style: GoogleFonts.poppins()),
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {
              // Tambahkan logika untuk menangani ketika avatar ditekan
            },
          ),
        ],
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            ListTile(
              title: Text('Kelas 7', style: GoogleFonts.poppins()),
              onTap: () {
                // Navigasi ke detail kursus
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CourseDetailPage()),
                );
              },
            ),

            ListTile(
              title: Text('Kelas 8', style: GoogleFonts.poppins()),
              onTap: () {
                // Navigasi ke detail kursus
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CourseDetailPage()),
                );
              },
            ),
            ListTile(
              title: Text('Kelas 9', style: GoogleFonts.poppins()),
              onTap: () {
                // Navigasi ke detail kursus
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CourseDetailPage()),
                );
              },
            ),
            // Tambahkan daftar kursus lainnya di sini
          ],
        ),
      ),
    );
  }
}
