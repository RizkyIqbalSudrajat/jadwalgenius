import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CourseDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Kelas 7', style: GoogleFonts.poppins()),
          actions: [
            IconButton(
              icon: Icon(Icons.account_circle),
              onPressed: () {
                // Tambahkan logika untuk menangani ketika avatar ditekan
              },
            ),
          ],
        ),
        body:
            ListView(padding: EdgeInsets.symmetric(horizontal: 10), children: [
          Column(
            children: <Widget>[
              Text(
                'Semester 1',
                style: GoogleFonts.poppins(fontSize: 20.0),
              ),
              SizedBox(height: 10.0),
              Column(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.black), // Tambahkan garis tepi
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Judul',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(height: 5), // Jarak antara judul dan subjudul
                        Text(
                          'Subjudul',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    title: Text('Bab 1'),
                    subtitle: Text("Konjungsi"),
                    onTap: () {},
                  ),
                  Divider(
                    height: 0,
                    indent: 10,
                    endIndent: 10,
                  ),
                  ListTile(
                    title: Text('Bab 1'),
                    subtitle: Text("Konjungsi"),
                    onTap: () {},
                  ),
                  Divider(
                    height: 0,
                    indent: 10,
                    endIndent: 10,
                  ),
                  ListTile(
                    title: Text('Bab 1'),
                    subtitle: Text("Konjungsi"),
                    onTap: () {},
                  ),
                  Divider(
                    height: 0,
                    indent: 10,
                    endIndent: 10,
                  ),
                  ListTile(
                    title: Text('Bab 1'),
                    subtitle: Text("Konjungsi"),
                    onTap: () {},
                  ),
                ],
              ),
              Text(
                'Semester 2',
                style: GoogleFonts.poppins(fontSize: 20.0),
              ),
              SizedBox(height: 10.0),
              Column(
                children: [
                  ListTile(
                    title: Text('Bab 1'),
                    subtitle: Text("Konjungsi"),
                    onTap: () {},
                  ),
                  Divider(
                    height: 0,
                    indent: 10,
                    endIndent: 10,
                  ),
                  ListTile(
                    title: Text('Bab 1'),
                    subtitle: Text("Konjungsi"),
                    onTap: () {},
                  ),
                  Divider(
                    height: 0,
                    indent: 10,
                    endIndent: 10,
                  ),
                  ListTile(
                    title: Text('Bab 1'),
                    subtitle: Text("Konjungsi"),
                    onTap: () {},
                  ),
                  Divider(
                    height: 0,
                    indent: 10,
                    endIndent: 10,
                  ),
                  ListTile(
                    title: Text('Bab 1'),
                    subtitle: Text("Konjungsi"),
                    onTap: () {},
                  ),
                  Divider(
                    height: 0,
                    indent: 10,
                    endIndent: 10,
                  ),
                  ListTile(
                    title: Text('Bab 1'),
                    subtitle: Text("Konjungsi"),
                    onTap: () {},
                  ),
                ],
              ),
            ],
          ),
        ]));
  }
}