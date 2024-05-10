import 'package:flutter/material.dart';


class LMSHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LMS Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
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
