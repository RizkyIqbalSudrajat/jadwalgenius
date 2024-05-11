import 'package:EduPlan/PKN/create.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class kelas7 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        title: Text(
          'Kelas 7',
          style: GoogleFonts.poppins(color: Colors.white),
        ),
        backgroundColor: const Color(0xffEEC143),
        shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        toolbarHeight: 50,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Semester 1',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 5, // Change the number of items as needed
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8, bottom: 5),
                  child: GestureDetector(
                    onTap: () {
                      // Tambahkan logika yang ingin Anda jalankan saat kartu ditekan
                      print('Card ${index + 1} pressed');
                    },
                    child: Card(
                      elevation:
                          4, // Nilai yang lebih rendah untuk bayangan yang lebih halus
                      child: ListTile(
                        title: Text(
                          'Item ${index + 1}',
                          style: GoogleFonts.poppins(),
                        ),
                        subtitle: Text(
                          'Subtitle for Item ${index + 1}',
                          style: GoogleFonts.poppins(),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Semester 2',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 5, // Change the number of items as needed
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8, bottom: 5),
                  child: GestureDetector(
                    onTap: () {
                      // Tambahkan logika yang ingin Anda jalankan saat kartu ditekan
                      print('Card ${index + 1} pressed');
                    },
                    child: Card(
                      elevation:
                          4, // Nilai yang lebih rendah untuk bayangan yang lebih halus
                      child: ListTile(
                        title: Text(
                          'Item ${index + 1}',
                          style: GoogleFonts.poppins(),
                        ),
                        subtitle: Text(
                          'Subtitle for Item ${index + 1}',
                          style: GoogleFonts.poppins(),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            PageRouteBuilder(
              transitionDuration:
                  Duration(milliseconds: 250), // Durasi transisi
              pageBuilder: (_, __, ___) =>
                  CreatePage(), // Widget yang akan ditampilkan
              transitionsBuilder: (_, animation, __, child) {
                return SlideTransition(
                  // Efek transisi slide
                  position: Tween<Offset>(
                    begin: const Offset(
                        1.0, 0.0), // Mulai dari luar layar sebelah kanan
                    end: Offset
                        .zero, // Posisi akhir, nol karena ingin pindah ke tengah layar
                  ).animate(animation),
                  child: child,
                );
              },
            ),
          );
        },
        backgroundColor: Color(0xffEEC143),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
