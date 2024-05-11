import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';

class CreatePage extends StatefulWidget {
  @override
  _CreatePageState createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  String? _selectedKelas;
  String? _selectedSemester;
  List<String> _semesterOptions = [];
  List<File> _selectedFiles = []; // List to store all selected files

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
          'Tambah Materi',
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
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                style: GoogleFonts.poppins(),
                decoration: InputDecoration(
                  labelText: 'Judul Materi',
                  labelStyle: GoogleFonts.poppins(),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                style: GoogleFonts.poppins(),
                decoration: InputDecoration(
                  labelText: 'Keterangan Materi',
                  labelStyle: GoogleFonts.poppins(),
                ),
                maxLines: 3,
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: 'Kelas',
                        labelStyle: GoogleFonts.poppins(),
                      ),
                      value: _selectedKelas,
                      items: ['Kelas 7', 'Kelas 8', 'Kelas 9']
                          .map((kelas) => DropdownMenuItem<String>(
                                value: kelas,
                                child: Text(
                                  kelas,
                                  style: GoogleFonts.poppins(),
                                ),
                              ))
                          .toList(),
                      onChanged: (String? selectedKelas) {
                        setState(() {
                          _selectedKelas = selectedKelas;
                          _selectedSemester = null; // Reset selected semester
                          _semesterOptions = _getSemesterOptions(selectedKelas);
                        });
                      },
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: Opacity(
                      opacity: _selectedKelas != null ? 1.0 : 0.5,
                      child: DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: 'Semester',
                        ),
                        value: _selectedSemester,
                        items: _semesterOptions
                            .map((semester) => DropdownMenuItem<String>(
                                  value: semester,
                                  child: Text(
                                    semester,
                                    style: GoogleFonts.poppins(),
                                  ),
                                ))
                            .toList(),
                        onChanged: (String? selectedSemester) {
                          setState(() {
                            _selectedSemester = selectedSemester;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  final result = await FilePicker.platform.pickFiles();
                  if (result != null) {
                    setState(() {
                      _selectedFiles
                          .addAll(result.files.map((file) => File(file.path!)));
                    });
                  }
                },
                child: Text(
                  'Pilih File',
                  style: GoogleFonts.poppins(),
                ),
              ),
              SizedBox(height: 15),
              // Display selected files
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: _selectedFiles.map((file) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Card(
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            Icon(_getFileIcon(file.path)),
                            SizedBox(width: 10),
                            Text(
                              file.path.split('/').last,
                              style: GoogleFonts.poppins(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<String> _getSemesterOptions(String? kelas) {
    if (kelas == 'Kelas 7') {
      return ['Semester 1', 'Semester 2'];
    } else if (kelas == 'Kelas 8') {
      return ['Semester 3', 'Semester 4'];
    } else if (kelas == 'Kelas 9') {
      return ['Semester 5', 'Semester 6'];
    } else {
      return [];
    }
  }

  IconData _getFileIcon(String path) {
    if (path.toLowerCase().endsWith('.pdf')) {
      return Icons.picture_as_pdf;
    } else if (path.toLowerCase().endsWith('.doc') ||
        path.toLowerCase().endsWith('.docx')) {
      return Icons.description;
    } else if (path.toLowerCase().endsWith('.xls') ||
        path.toLowerCase().endsWith('.xlsx')) {
      return Icons.table_chart;
    } else if (path.toLowerCase().endsWith('.ppt') ||
        path.toLowerCase().endsWith('.pptx')) {
      return Icons.slideshow;
    } else if (path.toLowerCase().endsWith('.jpg') ||
        path.toLowerCase().endsWith('.jpeg') ||
        path.toLowerCase().endsWith('.png')) {
      return Icons.image;
    } else if (path.toLowerCase().endsWith('.mp4') ||
        path.toLowerCase().endsWith('.mov')) {
      return Icons.videocam;
    } else {
      return Icons.insert_drive_file;
    }
  }
}
