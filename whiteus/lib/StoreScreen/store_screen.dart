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
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
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

  final Reference storageRef =
      FirebaseStorage.instance.ref('').child('');
  List<String> titles = [];

  // Method to upload an mp3 file to the server
  Future<void> uploadMp3(File file, String fileName) async {
    FirebaseStorage.instance.ref('$fileName').putFile(file);
  }

  @override
  void initState() {
    super.initState();
    _fetchTitles();
  }

  Future<void> _fetchTitles() async {
    try {
      final ListResult result = await storageRef.listAll();
      final List<String> newTitles = [];
      for (final ref in result.items) {
        final metadata = await ref.getMetadata();
        final title = metadata.name;
        newTitles.add(title);
      }
      setState(() {
        titles = newTitles;
      });
    } catch (e) {
      print('Error fetching titles: $e');
    }
  }

  Future<void> _downloadFile(String title) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/$title.mp3');
      final ref = storageRef.child(title);
      await ref.writeToFile(file);
      print('Downloaded file: ${file.path}');
    } catch (e) {
      print('Error downloading file: $e');
    }
  }

  // Method to download an mp3 file from the server
  // Future<void> downloadMp3() async {
  //   String downloadUrl = "";
  //   final FirebaseStorage storage = FirebaseStorage.instance;
  //
  //   try {
  //     String fileName = "Over_the_Horizon.mp3";
  //     String filePath = "$fileName";
  //     downloadUrl = await storage.ref().child(filePath).getDownloadURL();
  //     HttpClient httpClient = HttpClient();
  //     HttpClientRequest request = await httpClient.getUrl(Uri.parse(downloadUrl));
  //     HttpClientResponse response = await request.close();
  //     Uint8List bytes = await consolidateHttpClientResponseBytes(response);
  //     File file = File(fileName);
  //     await file.writeAsBytes(bytes);
  //   } catch (e) {
  //     print(e);
  //   }
  // }

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
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await pickMp3();
        },
        backgroundColor: Colors.blue.shade200,
        child: const Icon(Icons.add),
      ),
      // body: Column(
      //   children: [
      //     ElevatedButton(
      //       onPressed: () async {
      //         await downloadMp3();
      //       },
      //       child: Text('Download Mp3'),
      //     ),
      //     if (_filePath.isNotEmpty) ...[
      //       SizedBox(height: 16),
      //       Text(
      //         'Selected Mp3 File Path: $_filePath',
      //         style: TextStyle(fontSize: 16),
      //       ),
      //     ],
      //   ],
      // ),

      body: ListView.builder(
        itemCount: titles.length,
        itemBuilder: (BuildContext context, int index) {
          final title = titles[index];
          return ListTile(
            title: Text(title),
            trailing: IconButton(
              icon: Icon(Icons.download),
              onPressed: () => _downloadFile(title),
            ),
          );
        },
      ),
    );
  }
}
