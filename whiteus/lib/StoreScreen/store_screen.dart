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
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:file_picker/file_picker.dart';

class Mp3UploaderDownloader extends StatefulWidget {
  const Mp3UploaderDownloader({super.key});

  @override
  _Mp3UploaderDownloaderState createState() => _Mp3UploaderDownloaderState();
}

class _Mp3UploaderDownloaderState extends State<Mp3UploaderDownloader> {
  String _filePath = '';

  // Method to upload an mp3 file to the server
  Future<void> uploadMp3(File file, String fileName) async {
    FirebaseStorage.instance.ref(fileName).putFile(file);
  }

  // Method to download an mp3 file from the server
  Future<void> downloadMp3() async {
    const url =
        'http://localhost:8000/download'; // Replace with your own download API url
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
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['mp3']);
    if (result != null) {
      File file = File(result.files.single.path.toString());
      String fileName = file.path.split('/').last;
      await uploadMp3(file, fileName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mp3 Uploader/Downloader'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                await pickMp3();
              },
              child: const Text('Upload Mp3'),
            ),
            ElevatedButton(
              onPressed: () async {
                await downloadMp3();
              },
              child: const Text('Download Mp3'),
            ),
            if (_filePath.isNotEmpty) ...[
              const SizedBox(height: 16),
              Text(
                'Selected Mp3 File Path: $_filePath',
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
