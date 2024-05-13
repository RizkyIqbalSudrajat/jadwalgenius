// Model untuk data materi PKN
import 'package:EduPlan/Biologi/create.dart';
import 'package:EduPlan/Biologi/materi.dart';
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

class kelas8 extends StatefulWidget {
  @override
  _kelas8State createState() => _kelas8State();
}

class _kelas8State extends State<kelas8> {
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
          'Kelas 8',
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
                'Semester 3',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            StreamBuilder<QuerySnapshot>(
              stream: firestoreService
                  .collection('Biologi')
                  .where('kelas', isEqualTo: 'Kelas 8')
                  .where('semester', isEqualTo: 'Semester 3')
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
                                                                              trailing: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              // Panggil fungsi untuk menghapus materi
                              _deleteMateri(materi.id);
                            },
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailMateriPage(
                                    materi: snapshot.data!.docs[index]),
                              ),
                            );
                          },
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
                'Semester 4',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            StreamBuilder<QuerySnapshot>(
              stream: firestoreService
                  .collection('Biologi')
                  .where('kelas', isEqualTo: 'Kelas 8')
                  .where('semester', isEqualTo: 'Semester 4')
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
                                                                              trailing: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              // Panggil fungsi untuk menghapus materi
                              _deleteMateri(materi.id);
                            },
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailMateriPage(
                                    materi: snapshot.data!.docs[index]),
                              ),
                            );
                          },
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
    void _deleteMateri(String materiId) {
  // Hapus materi dari Firestore berdasarkan ID
  firestoreService.collection('Biologi').doc(materiId).delete().then((value) {
    // Materi berhasil dihapus, lakukan apa yang diperlukan setelah penghapusan
    // Misalnya, tampilkan pesan sukses atau perbarui tampilan
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Materi berhasil dihapus'),
        duration: Duration(seconds: 2),
      ),
    );
  }).catchError((error) {
    // Handle error jika gagal menghapus materi
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Gagal menghapus materi: $error'),
        duration: Duration(seconds: 2),
      ),
    );
  });
}
}
