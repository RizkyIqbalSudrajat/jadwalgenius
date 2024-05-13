import 'package:EduPlan/PKN/kelas7.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';

class UpdatePage extends StatefulWidget {
  final DocumentSnapshot materi;

  const UpdatePage({Key? key, required this.materi}) : super(key: key);

  @override
  _UpdatePageState createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  late String _selectedKelas;
  late String _selectedSemester;
  List<File> _selectedFiles = [];
  final TextEditingController _judulMateriController = TextEditingController();
  final TextEditingController _keteranganMateriController =
      TextEditingController();
  bool _filesUploaded = false;

  @override
  void initState() {
    super.initState();
    _selectedKelas = widget.materi['kelas'];
    _selectedSemester = widget.materi['semester'];
    _judulMateriController.text = widget.materi['judulMateri'];
    _keteranganMateriController.text = widget.materi['keteranganMateri'];
    // Jika ada file terlampir, Anda dapat menginisialisasi _selectedFiles di sini
  }

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
          'Update Materi',
          style: GoogleFonts.poppins(color: Colors.white),
        ),
        backgroundColor: const Color(0xffEEC143),
        shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        toolbarHeight: 50,
        actions: [
          IconButton(
            onPressed: () {
              // Tambahkan logika untuk tombol "Simpan" di sini
              _updateMateri();
            },
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _judulMateriController,
                style: GoogleFonts.poppins(),
                decoration: InputDecoration(
                  labelText: 'Judul Materi',
                  labelStyle: GoogleFonts.poppins(),
                ),
                onChanged: (_) {
                  _updateUploadButtonVisibility();
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _keteranganMateriController,
                style: GoogleFonts.poppins(),
                decoration: InputDecoration(
                  labelText: 'Keterangan Materi',
                  labelStyle: GoogleFonts.poppins(),
                ),
                maxLines: null,
                onChanged: (_) {
                  _updateUploadButtonVisibility();
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  final result = await FilePicker.platform.pickFiles();
                  if (result != null) {
                    setState(() {
                      _selectedFiles
                          .addAll(result.files.map((file) => File(file.path!)));
                      _updateUploadButtonVisibility();
                    });
                  }
                },
                child: Text(
                  'Pilih File',
                  style: GoogleFonts.poppins(),
                ),
              ),
              const SizedBox(height: 15),
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
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                file.path.split('/').last,
                                style: GoogleFonts.poppins(),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedFiles.remove(file);
                                  _updateUploadButtonVisibility();
                                });
                              },
                              child: const Icon(Icons.close),
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

  void _updateUploadButtonVisibility() {
    setState(() {
      // Check if all required fields are filled and at least one file is selected
      _filesUploaded = _judulMateriController.text.isNotEmpty &&
          _keteranganMateriController.text.isNotEmpty &&
          _selectedFiles.isNotEmpty;
    });
  }

  void _updateMateri() {
    if (_filesUploaded) {
      // Mendapatkan instance Firestore
      final firestore = FirebaseFirestore.instance;

      // Menyiapkan data yang akan diperbarui
      final data = {
        'judulMateri': _judulMateriController.text,
        'keteranganMateri': _keteranganMateriController.text,
        'kelas': _selectedKelas,
        'semester': _selectedSemester,
        'files': _selectedFiles.map((file) {
          // Contoh menyimpan informasi file ke Firestore
          return {
            'fileName': file.path.split('/').last,
            'filePath': file.path, // atau URL file jika disimpan di Storage
            'fileType': _getFileIcon(file.path).toString(),
          };
        }).toList(),
        // Tambahkan data lain jika diperlukan
      };

      // Memperbarui data di Firestore
      firestore
          .collection('PKN')
          .doc(widget.materi.id) // Gunakan ID dokumen yang ingin diperbarui
          .update(data)
          .then((_) {
        // Data berhasil diperbarui
        print('Data berhasil diperbarui');
        Navigator.pop(context); // Kembali ke halaman sebelumnya
      }).catchError((error) {
        // Kesalahan saat memperbarui data
        print('Error: $error');
      });
    }
  }

  @override
  void dispose() {
    _judulMateriController.dispose();
    _keteranganMateriController.dispose();
    super.dispose();
  }
}
