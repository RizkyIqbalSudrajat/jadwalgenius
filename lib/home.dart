import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class LMSHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<String> images = [
      'https://example.com/image1.jpg',
      'https://example.com/image2.jpg',
      'https://example.com/image3.jpg',
    ]; // Ganti URL dengan URL gambar Anda
    return Scaffold(
      appBar: AppBar(
        title: Text('Helo Sobat EduPlan'),
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {
              // Tambahkan logika untuk menangani ketika avatar ditekan
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          CarouselSlider(
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
          Text(
            'Welcome to Flutter LMS!',
            style: TextStyle(fontSize: 24.0),
          ),
          SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () {
              // Navigasi ke halaman kursus
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CoursePage()),
              );
            },
            child: Text('Go to Courses'),
          ),
        ],
      ),
    );
  }
}

class CoursePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Courses'),
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
              title: Text('Flutter Basics'),
              subtitle: Text('Learn the basics of Flutter'),
              onTap: () {
                // Navigasi ke detail kursus
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CourseDetailPage()),
                );
              },
            ),
            ListTile(
              title: Text('Advanced Flutter'),
              subtitle: Text('Advanced topics in Flutter development'),
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
        title: Text('Course Details'),
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
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 10.0),
            Text(
              'Description: Learn the basics of Flutter framework to build mobile apps.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Lakukan aksi saat tombol ditekan (misalnya, memulai kursus)
              },
              child: Text('Start Course'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MyLMSApp());
}

class MyLMSApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter LMS',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LMSHomePage(),
    );
  }
}
