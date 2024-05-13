// Model untuk data materi PKN
import 'package:EduPlan/BhsIndonesia/create.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Model untuk data materi PKN
class Materi {
  final String id;
  final String judul;
  final String keterangan;

  Materi({
    required this.id,
    required this.judul,
    required this.keterangan,
  });
}

class kelas7 extends StatefulWidget {
  @override
  _kelas7State createState() => _kelas7State();
}

class _kelas7State extends State<kelas7> {
  final firestoreService = FirebaseFirestore.instance;

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
            StreamBuilder<QuerySnapshot>(
              stream: firestoreService
                  .collection('Bahasa Indonesia')
                  .where('kelas', isEqualTo: 'Kelas 7')
                  .where('semester', isEqualTo: 'Semester 1')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator(); // Show a loading indicator while waiting for data
                }

                if (snapshot.hasError || snapshot.data == null) {
                  return Text(
                      'Error: Data not available'); // Handle error or null snapshot
                }

                final materiList = snapshot.data!.docs
                    .map((doc) => Materi(
                          id: doc.id,
                          judul: doc['judulMateri'],
                          keterangan: doc['keteranganMateri'],
                        ))
                    .toList();
                if (materiList.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        'Belum ada materi untuk semester ini',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  );
                }
                return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: materiList.length,
                  itemBuilder: (context, index) {
                    final materi = materiList[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 2, horizontal: 8),
                      child: Card(
                        elevation: 4,
                        child: ListTile(
                          title: Text(
                            materi.judul,
                            style: GoogleFonts.poppins(),
                          ),
                          subtitle: Text(
                            materi.keterangan,
                            style: GoogleFonts.poppins(),
                          ),
                        ),
                      ),
                    );
                  },
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
            StreamBuilder<QuerySnapshot>(
              stream: firestoreService
                  .collection('Bahasa Indonesia')
                  .where('kelas', isEqualTo: 'Kelas 7')
                  .where('semester', isEqualTo: 'Semester 2')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator(); // Show a loading indicator while waiting for data
                }

                if (snapshot.hasError || snapshot.data == null) {
                  return Text(
                      'Error: Data not available'); // Handle error or null snapshot
                }

                final materiList = snapshot.data!.docs
                    .map((doc) => Materi(
                          id: doc.id,
                          judul: doc['judulMateri'],
                          keterangan: doc['keteranganMateri'],
                        ))
                    .toList();
                if (materiList.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        'Belum ada materi untuk semester ini',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  );
                }
                return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: materiList.length,
                  itemBuilder: (context, index) {
                    final materi = materiList[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 2, horizontal: 8),
                      child: Card(
                        elevation: 4,
                        child: ListTile(
                          title: Text(
                            materi.judul,
                            style: GoogleFonts.poppins(),
                          ),
                          subtitle: Text(
                            materi.keterangan,
                            style: GoogleFonts.poppins(),
                          ),
                        ),
                      ),
                    );
                  },
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
