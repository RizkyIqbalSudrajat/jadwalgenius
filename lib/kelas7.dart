import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CourseDetailPage extends StatelessWidget {
  const CourseDetailPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kelas 7', style: GoogleFonts.poppins()),
        actions: [],
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
                  (index) => AnimatedContainerItem(index + 1),
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
                  (index) => AnimatedContainerItem(index + 1),
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Tambahkan fungsi yang ingin dijalankan ketika FAB ditekan
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class AnimatedContainerItem extends StatefulWidget {
  final int babNumber;

  const AnimatedContainerItem(this.babNumber, {Key? key}) : super(key: key);

  @override
  _AnimatedContainerItemState createState() => _AnimatedContainerItemState();
}

class _AnimatedContainerItemState extends State<AnimatedContainerItem> {
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    // Mengatur _isVisible menjadi true dengan delay menggunakan Timer
    // Ini akan memulai animasi opacity saat widget ini dibuat.
    Future.delayed(Duration(milliseconds: 100 * widget.babNumber), () {
      setState(() {
        _isVisible = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _isVisible ? 1.0 : 0.0,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      child: Container(
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
              'Bab ${widget.babNumber}',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            Divider(),
            Text(
              'Konjungsi',
              style: GoogleFonts.poppins(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
