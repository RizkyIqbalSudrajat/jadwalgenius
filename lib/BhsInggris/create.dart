import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';

class CreatePage extends StatefulWidget {
  const CreatePage({Key? key}) : super(key: key);

  @override
  _CreatePageState createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  String? _selectedKelas;
  String? _selectedSemester;
  List<String> _semesterOptions = [];
  final List<File> _selectedFiles = [];
  final TextEditingController _judulMateriController = TextEditingController();
  final TextEditingController _keteranganMateriController = TextEditingController();
  bool _filesUploaded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Materi'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // TextFields for Judul Materi and Keterangan Materi
            TextFormField(
              controller: _judulMateriController,
              decoration: InputDecoration(labelText: 'Judul Materi'),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _keteranganMateriController,
              decoration: InputDecoration(labelText: 'Keterangan Materi'),
              maxLines: null,
            ),
            SizedBox(height: 20),
            // Dropdowns for Kelas and Semester
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _selectedKelas,
                    items: ['Kelas 7', 'Kelas 8', 'Kelas 9']
                        .map((kelas) => DropdownMenuItem<String>(
                              value: kelas,
                              child: Text(kelas),
                            ))
                        .toList(),
                    onChanged: (selectedKelas) {
                      setState(() {
                        _selectedKelas = selectedKelas;
                        _selectedSemester = null;
                        _semesterOptions = _getSemesterOptions(selectedKelas!);
                        _updateUploadButtonVisibility();
                      });
                    },
                    decoration: InputDecoration(labelText: 'Kelas'),
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _selectedSemester,
                    items: _semesterOptions
                        .map((semester) => DropdownMenuItem<String>(
                              value: semester,
                              child: Text(semester),
                            ))
                        .toList(),
                    onChanged: (selectedSemester) {
                      setState(() {
                        _selectedSemester = selectedSemester;
                        _updateUploadButtonVisibility();
                      });
                    },
                    decoration: InputDecoration(labelText: 'Semester'),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            // Button to pick files
            ElevatedButton(
              onPressed: _pickFiles,
              child: Text('Pilih File'),
            ),
            SizedBox(height: 20),
            // List of selected files
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: _selectedFiles.map((file) {
                return ListTile(
                  leading: Icon(_getFileIcon(file.path)),
                  title: Text(file.path.split('/').last),
                  trailing: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      setState(() {
                        _selectedFiles.remove(file);
                        _updateUploadButtonVisibility();
                      });
                    },
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            // Button to upload files
            Visibility(
              visible: _filesUploaded,
              child: ElevatedButton(
                onPressed: _uploadFiles,
                child: Text('Unggah'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<String> _getSemesterOptions(String kelas) {
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

  void _pickFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        _selectedFiles.addAll(result.files.map((file) => File(file.path!)));
        _updateUploadButtonVisibility();
      });
    }
  }

  bool _canUpload() {
    return _selectedKelas != null &&
        _selectedSemester != null &&
        _judulMateriController.text.isNotEmpty &&
        _keteranganMateriController.text.isNotEmpty &&
        _selectedFiles.isNotEmpty;
  }

  void _updateUploadButtonVisibility() {
    setState(() {
      _filesUploaded = _canUpload();
    });
  }

void _uploadFiles() async {
  try {
    List<Map<String, dynamic>> uploadedFiles = [];
    final FirebaseStorage storage = FirebaseStorage.instance;
    final CollectionReference materiCollection =
        FirebaseFirestore.instance.collection('BahasaInggris');

    for (File file in _selectedFiles) {
      String fileName = file.path.split('/').last;
      Reference ref = storage.ref().child('materi').child(fileName);

      await ref.putFile(file);

      String fileUrl = await ref.getDownloadURL();
      String fileType = _getFileType(fileName); // Determine file type based on extension

      uploadedFiles.add({
        'fileName': fileName,
        'fileUrl': fileUrl,
        'fileType': fileType,
      });
    }

    // Data to be saved in Firestore
    Map<String, dynamic> data = {
      'judulMateri': _judulMateriController.text,
      'keteranganMateri': _keteranganMateriController.text,
      'kelas': _selectedKelas,
      'semester': _selectedSemester,
      'files': uploadedFiles,
    };

    await materiCollection.add(data);

    // Clear fields and update state after successful upload
    _judulMateriController.clear();
    _keteranganMateriController.clear();
    setState(() {
      _selectedKelas = null;
      _selectedSemester = null;
      _selectedFiles.clear();
      _filesUploaded = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('File berhasil diunggah dan data disimpan'),
        duration: Duration(seconds: 2),
      ),
    );
  } catch (e) {
    print('Error uploading files: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Gagal mengunggah file: $e'),
        duration: Duration(seconds: 2),
      ),
    );
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
