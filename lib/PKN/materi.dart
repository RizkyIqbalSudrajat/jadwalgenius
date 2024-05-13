import 'package:EduPlan/PKN/kelas7.dart';
import 'package:EduPlan/PKN/update.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailMateriPage extends StatelessWidget {
  final DocumentSnapshot materi;

  const DetailMateriPage({Key? key, required this.materi}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String judul = materi['judulMateri'];
    final String keterangan = materi['keteranganMateri'];
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
          judul,
          style: GoogleFonts.poppins(color: Colors.white),
        ),
        backgroundColor: const Color(0xffEEC143),
        actions: [
          IconButton(
            onPressed: () {
              // Tambahkan logika untuk tombol "Update" di sini
              // Contoh: Navigasi ke halaman update atau jalankan fungsi update
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UpdatePage(materi: materi),
                ),
              );
            },
            icon: const Icon(
              Icons.edit,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              keterangan,
              style: GoogleFonts.poppins(),
            ),
            // Tambahkan informasi tambahan atau detail lainnya
          ],
        ),
      ),
    );
  }
}
