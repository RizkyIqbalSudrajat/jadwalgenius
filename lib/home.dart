import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';

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
      },
      {
        'name': 'Bahasa Inggris',
        'icon': Icons.language,
      },
      {
        'name': 'Matematika',
        'icon': Icons.calculate,
      },
      {
        'name': 'Bahasa Indonesia',
        'icon': Icons.book,
      },
      {
        'name': 'Fisika',
        'icon': Icons.science,
      },
      {
        'name': 'Biologi',
        'icon': Icons.biotech,
      },
      {
        'name': 'Agama',
        'icon': Icons.star,
      },
      {
        'name': 'Olahraga',
        'icon': Icons.sports_soccer,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Helo Sobat EduPlan', style: GoogleFonts.poppins(color: Colors.white)),
        backgroundColor: Color(0xffEEC143),
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30), // Mengatur border radius untuk melengkung
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {
              // Tambahkan logika untuk menangani ketika avatar ditekan
            },
          ),
        ],
      ),
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
                style: GoogleFonts.poppins(fontSize: 19.0),
              ),
            ),
            GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(), // Tidak dapat digulir
              crossAxisCount: 3,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
              padding: EdgeInsets.all(10.0),
              children: subjects.map((subject) {
                return GestureDetector(
                  onTap: () {
                    // Navigasi ke halaman kursus
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CoursePage()),
                    );
                  },
                  child: Card(
                    elevation: 5.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(subject['icon'], size: 40.0),
                        SizedBox(height: 5.0),
                        Center(
                          child: Text(subject['name'],
                              style: GoogleFonts.poppins(fontSize: 10.0)),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}


class CoursePage extends StatelessWidget {
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
              title: Text('Flutter Basics', style: GoogleFonts.poppins()),
              subtitle: Text('Learn the basics of Flutter',
                  style: GoogleFonts.poppins()),
              onTap: () {
                // Navigasi ke detail kursus
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CourseDetailPage()),
                );
              },
            ),
            ListTile(
              title: Text('Advanced Flutter', style: GoogleFonts.poppins()),
              subtitle: Text('Advanced topics in Flutter development',
                  style: GoogleFonts.poppins()),
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

class CourseDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Course Details', style: GoogleFonts.poppins()),
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Course Name: Flutter Basics',
              style: GoogleFonts.poppins(fontSize: 20.0),
            ),
            SizedBox(height: 10.0),
            Text(
              'Description: Learn the basics of Flutter framework to build mobile apps.',
              style: GoogleFonts.poppins(fontSize: 16.0),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Lakukan aksi saat tombol ditekan (misalnya, memulai kursus)
              },
              child: Text('Start Course', style: GoogleFonts.poppins()),
            ),
          ],
        ),
      ),
    );
  }
}
