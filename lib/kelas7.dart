import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CourseDetailPage extends StatelessWidget {
  const CourseDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Kelas 7', style: GoogleFonts.poppins()),
          actions: [
          ],
        ),
        body: ListView(
          children: [
            Column(
              children: <Widget>[
                Text(
                  'Semester 1',
                  style: GoogleFonts.poppins(fontSize: 20.0),
                ),
                SizedBox(height: 10.0),
                Column(
                  children: List.generate(
                    5, // Ubah ini sesuai jumlah item yang Anda butuhkan
                    (index) => ContainerItem(index + 1),
                  ),
                ),
                Divider(),
                Text(
                  'Semester 2',
                  style: GoogleFonts.poppins(fontSize: 20.0),
                ),
                SizedBox(height: 10.0),
                Column(
                  children: List.generate(
                    5, // Ubah ini sesuai jumlah item yang Anda butuhkan
                    (index) => ContainerItem(index + 1),
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}

class ContainerItem extends StatelessWidget {
  final int babNumber;

  const ContainerItem(this.babNumber, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
      padding: EdgeInsets.all(10),
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Bab $babNumber',
            style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          Divider(),
          Text(
            'Konjungsi',
            style: GoogleFonts.poppins(fontSize: 14),
          ),
        ],
      ),
    );
  }
}
