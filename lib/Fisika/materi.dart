import 'dart:io';
import 'package:EduPlan/Fisika/update.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class DetailMateriPage extends StatelessWidget {
  final DocumentSnapshot materi;

  const DetailMateriPage({Key? key, required this.materi}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String judul = materi['judulMateri'];
    final String keterangan = materi['keteranganMateri'];
    final List<dynamic> files = materi['files'];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          judul,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xffEEC143),
        actions: [
          IconButton(
            onPressed: () {
              // Navigasi ke halaman UpdatePage dengan membawa data materi
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UpdatePage(materi: materi),
                ),
              );
            },
            icon: Icon(Icons.edit),
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
              style: TextStyle(),
            ),
            const SizedBox(height: 16.0),
            Text(
              'File Materi:',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            // Tampilkan daftar file terkait dengan materi
            ListView.builder(
              shrinkWrap: true,
              itemCount: files.length,
              itemBuilder: (context, index) {
                final file = files[index];
                final String fileName = file['fileName'];
                final String fileUrl = file['fileUrl'];
                final String fileType = file['fileType'];

                // Tampilkan widget sesuai dengan jenis file
                if (fileType == 'PDF Document') {
                  return _buildFileCard(
                    context,
                    fileName,
                    fileUrl,
                    () {
                      _downloadFile(fileUrl, fileName, context);
                    },
                  );
                } else if (fileType == 'Image') {
                  return Image.network(
                    fileUrl,
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                  );
                }
                if (fileType == 'PowerPoint Presentation') {
                  return _buildFileCard(
                    context,
                    fileName,
                    fileUrl,
                    () {
                      _downloadFile(fileUrl, fileName, context);
                    },
                  );
                }
                if (fileType == 'Word Document') {
                  return _buildFileCard(
                    context,
                    fileName,
                    fileUrl,
                    () {
                      _downloadFile(fileUrl, fileName, context);
                    },
                  );
                }
                if (fileType == 'Excel Spreadsheet') {
                  return _buildFileCard(
                    context,
                    fileName,
                    fileUrl,
                    () {
                      _downloadFile(fileUrl, fileName, context);
                    },
                  );
                }
                if (fileType == 'Video') {
                  return _buildFileCard(
                    context,
                    fileName,
                    fileUrl,
                    () {
                      _downloadFile(fileUrl, fileName, context);
                    },
                  );
                } else {
                  return Text('Unsupported file type: $fileType');
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _downloadFile(
    String fileUrl,
    String fileName,
    BuildContext context,
  ) async {
    final url = Uri.parse(fileUrl);

    try {
      if (await canLaunch(fileUrl)) {
        await launch(fileUrl);
      } else {
        throw 'Could not launch $fileUrl';
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to launch file: $e'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    final directory = await getExternalStorageDirectory();
    final filePath = '${directory!.path}/Download/$fileName';

    try {
      final response = await http.get(url);
      final File file = File(filePath);
      await file.writeAsBytes(response.bodyBytes);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('File $fileName berhasil diunduh'),
          duration: Duration(seconds: 2),
        ),
      );
    } catch (e) {}
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

  Widget _buildFileCard(
    BuildContext context,
    String fileName,
    String fileUrl,
    VoidCallback onTap,
  ) {
    return Card(
      elevation: 4,
      child: ListTile(
        leading: Icon(_getFileIcon(fileName)),
        title: Text(
          fileName,
          style: TextStyle(fontSize: 16),
        ),
        onTap: onTap,
      ),
    );
  }
}
