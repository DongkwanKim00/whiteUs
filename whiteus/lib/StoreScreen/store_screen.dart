import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:file_picker/file_picker.dart';

class Mp3UploaderDownloader extends StatefulWidget {
  const Mp3UploaderDownloader({
    super.key,
  });

  @override
  _Mp3UploaderDownloaderState createState() => _Mp3UploaderDownloaderState();
}

class _Mp3UploaderDownloaderState extends State<Mp3UploaderDownloader>
    with AutomaticKeepAliveClientMixin<Mp3UploaderDownloader> {
  final Reference storageRef = FirebaseStorage.instance.ref('').child('');
  List<String> titles = [];
  late Future<bool> titlesReady;

  // Method to upload an mp3 file to the server
  Future<void> uploadMp3(File file, String fileName) async {
    FirebaseStorage.instance.ref(fileName).putFile(file);
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    titlesReady = _fetchTitles();
  }

  Future<bool> _fetchTitles() async {
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
      return true;
    } catch (e) {
      print('Error fetching titles: $e');
      return false;
    }
  }

  Future<void> _downloadFile(String title) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/$title');
      final ref = storageRef.child(title);
      await ref.writeToFile(file);
      print('Downloaded file: ${file.path}');
    } catch (e) {
      print('Error downloading file: $e');
    }
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
    super.build(context);
    return Scaffold(
      body: FutureBuilder(
          future: titlesReady,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.white),
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: Text("Data Fetch Error"),
              );
            } else {
              return ListView.builder(
                itemCount: titles.length,
                itemBuilder: (BuildContext context, int index) {
                  final title = titles[index];
                  return Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.teal.shade900, Colors.teal.shade500],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      title: Text(
                        title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      leading:
                          const Icon(Icons.music_note, color: Colors.white),
                      trailing: IconButton(
                        icon: const Icon(Icons.download, color: Colors.white),
                        onPressed: () => _downloadFile(title),
                      ),
                    ),
                  );
                },
              );
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await pickMp3();
        },
        backgroundColor: Colors.pinkAccent.shade200,
        child: const Icon(Icons.add),
      ),
    );
  }
}
