import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:file_picker/file_picker.dart';

class UpdatePage extends StatefulWidget {
  final DocumentSnapshot materi;

  const UpdatePage({Key? key, required this.materi}) : super(key: key);

  @override
  _UpdatePageState createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  late String _selectedKelas;
  late String _selectedSemester;
  late List<Map<String, dynamic>> _selectedFiles = [];
  final TextEditingController _judulMateriController = TextEditingController();
  final TextEditingController _keteranganMateriController =
      TextEditingController();
  bool _filesUploaded = false;
  final storage = FirebaseStorage.instance;

  @override
  void initState() {
    super.initState();
    _selectedKelas = widget.materi['kelas'];
    _selectedSemester = widget.materi['semester'];
    _judulMateriController.text = widget.materi['judulMateri'];
    _keteranganMateriController.text = widget.materi['keteranganMateri'];
    _selectedFiles = List<Map<String, dynamic>>.from(widget.materi['files']);

    // Update upload button visibility based on attached files
    _updateUploadButtonVisibility();
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
              // Add logic for "Save" button here
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
                      _selectedFiles.addAll(
                        result.files.map(
                          (file) => {
                            'fileName': file.name,
                            'fileUrl': file.path,
                            'fileType': _getFileType(file.name),
                          },
                        ),
                      );
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
                            Icon(_getFileIcon(file['fileName'])),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                file['fileName'],
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

  IconData _getFileIcon(String fileName) {
    if (fileName.toLowerCase().endsWith('.pdf')) {
      return Icons.picture_as_pdf;
    } else if (fileName.toLowerCase().endsWith('.doc') ||
        fileName.toLowerCase().endsWith('.docx')) {
      return Icons.description;
    } else if (fileName.toLowerCase().endsWith('.xls') ||
        fileName.toLowerCase().endsWith('.xlsx')) {
      return Icons.table_chart;
    } else if (fileName.toLowerCase().endsWith('.ppt') ||
        fileName.toLowerCase().endsWith('.pptx')) {
      return Icons.slideshow;
    } else if (fileName.toLowerCase().endsWith('.jpg') ||
        fileName.toLowerCase().endsWith('.jpeg') ||
        fileName.toLowerCase().endsWith('.png')) {
      return Icons.image;
    } else if (fileName.toLowerCase().endsWith('.mp4') ||
        fileName.toLowerCase().endsWith('.mov')) {
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

  Future<void> _updateMateri() async {
    if (_filesUploaded) {
      try {
        final firestore = FirebaseFirestore.instance;

        List<Map<String, dynamic>> uploadedFiles = [];

        for (Map<String, dynamic> fileData in _selectedFiles) {
          String fileName = fileData['fileName'];
          String filePath = fileData['fileUrl'];
          File file = File(filePath);

          String fileUrl = ''; // Default empty URL

          if (filePath.isNotEmpty && file.existsSync()) {
            // File path exists, meaning file was selected again
            fileUrl = await _uploadFileToFirebaseStorage(file);
          } else {
            // No file path, retain existing file URL
            fileUrl = fileData['fileUrl'] ?? '';
          }

          uploadedFiles.add({
            'fileName': fileName,
            'fileUrl': fileUrl,
            'fileType': _getFileType(fileName),
          });
        }

        // Data of the materi to be updated in Firestore
        final data = {
          'judulMateri': _judulMateriController.text,
          'keteranganMateri': _keteranganMateriController.text,
          'kelas': _selectedKelas,
          'semester': _selectedSemester,
          'files': uploadedFiles, // Uploaded file information
          // Add other data if needed
        };

        // Update materi data in Firestore
        await firestore.collection('Agama').doc(widget.materi.id).update(data);

        // Data successfully updated
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Data berhasil diperbarui'),
            duration: Duration(seconds: 2),
          ),
        );

        // Navigate back to previous page
        Navigator.pop(context);
      } catch (e) {
        // Handle errors during file upload or data saving
        print('Error: $e');
        // Show error message to the user
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal mengupdate materi: $e'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } else {
      // Show message if any field is not filled correctly
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Harap lengkapi semua bidang terlebih dahulu'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  Future<String> _uploadFileToFirebaseStorage(File file) async {
    try {
      FirebaseStorage storage = FirebaseStorage.instance;
      String fileName = file.path.split('/').last;
      Reference ref = storage.ref().child('files').child(fileName);

      UploadTask uploadTask = ref.putFile(file);
      TaskSnapshot snapshot = await uploadTask;

      // Get download URL of the uploaded file
      String fileUrl = await snapshot.ref.getDownloadURL();

      return fileUrl;
    } catch (e) {
      print('Error uploading file to Firebase Storage: $e');
      return '';
    }
  }

  String _getFileType(String fileName) {
    String extension = fileName.split('.').last.toLowerCase();
    switch (extension) {
      case 'pdf':
        return 'PDF Document';
      case 'doc':
      case 'docx':
        return 'Word Document';
      case 'xls':
      case 'xlsx':
        return 'Excel Spreadsheet';
      case 'ppt':
      case 'pptx':
        return 'PowerPoint Presentation';
      case 'jpg':
      case 'jpeg':
      case 'png':
        return 'Image';
      case 'mp4':
      case 'mov':
        return 'Video';
      default:
        return 'File';
    }
  }

  @override
  void dispose() {
    _judulMateriController.dispose();
    _keteranganMateriController.dispose();
    super.dispose();
  }
}
