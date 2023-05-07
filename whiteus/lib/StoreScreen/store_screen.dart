// import 'package:flutter/material.dart';
//
// class StoreScreen extends StatelessWidget {
//   const StoreScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       // body: Container(
//       //   child: const Text("Store Screen"),
//       // ),
//     );
//   }
// }

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:file_picker/file_picker.dart';

class Mp3UploaderDownloader extends StatefulWidget {
  @override
  _Mp3UploaderDownloaderState createState() => _Mp3UploaderDownloaderState();
}

class _Mp3UploaderDownloaderState extends State<Mp3UploaderDownloader> {
  String _filePath = '';

  // Method to upload an mp3 file to the server
  Future<void> uploadMp3(File file) async {
    final url = 'http://localhost:8000/upload'; // Replace with your own upload API url
    final request = http.MultipartRequest('POST', Uri.parse(url));
    request.files.add(await http.MultipartFile.fromPath('mp3', file.path));
    final response = await request.send();
    if (response.statusCode == 200) {
      print('Mp3 file uploaded successfully');
    } else {
      print('Error uploading mp3 file');
    }
  }

  // Method to download an mp3 file from the server
  Future<void> downloadMp3() async {
    final url = 'http://localhost:8000/download'; // Replace with your own download API url
    final response = await http.get(Uri.parse(url));
    final bytes = response.bodyBytes;
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/downloaded.mp3');
    await file.writeAsBytes(bytes);
    setState(() {
      _filePath = file.path;
    });
    print('Mp3 file downloaded successfully');
  }

  // Method to pick an mp3 file from the device's file system
  Future<void> pickMp3() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['mp3'],
    );
    if (result != null) {
      final file = File(result.files.single.path!);
      setState(() {
        _filePath = file.path;
      });
      await uploadMp3(file);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mp3 Uploader/Downloader'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                await pickMp3();
              },
              child: Text('Upload Mp3'),
            ),
            ElevatedButton(
              onPressed: () async {
                await downloadMp3();
              },
              child: Text('Download Mp3'),
            ),
            if (_filePath.isNotEmpty) ...[
              SizedBox(height: 16),
              Text(
                'Selected Mp3 File Path: $_filePath',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ],
        ),
      ),
    );
  }
}