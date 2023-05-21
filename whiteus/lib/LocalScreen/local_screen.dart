import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class AudioFile {
  String name;
  String path;

  AudioFile({required this.name, required this.path});
}

class AudioPlayerPage extends StatefulWidget {
  @override
  _AudioPlayerPageState createState() => _AudioPlayerPageState();
}

class _AudioPlayerPageState extends State<AudioPlayerPage>
    with WidgetsBindingObserver {
  late AudioPlayer audioPlayer;
  List<AudioFile> audioFiles = [];

  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();
    loadAudioFiles();
  }

  Future<void> loadAudioFiles() async {
    Directory directory =
        Directory('/data/user/0/com.example.whiteus/app_flutter/');
    List<FileSystemEntity> files = directory.listSync();

    audioFiles.clear();

    for (var file in files) {
      if (file.path.endsWith('.mp3')) {
        String fileName = file.path.split('/').last;
        audioFiles.add(AudioFile(name: fileName, path: file.path));
      }
    }

    setState(() {});
  }

  // void playAudio(String path) async {
  //   await audioPlayer.play(DeviceFileSource(path));
  // }

  void playAudio(String path) async {
    await audioPlayer.play(UrlSource(path));
  }

  void pauseAudio() async {
    await audioPlayer.pause();
  }

  void deleteFile(String path) {
    File file = File(path);
    file.deleteSync();
    loadAudioFiles();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.paused) {
      pauseAudio();
    } else if (state == AppLifecycleState.resumed) {
      // Resume audio playback if needed
    }
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Audio Player'),
      ),
      body: ListView.builder(
        itemCount: audioFiles.length,
        itemBuilder: (context, index) {
          AudioFile audioFile = audioFiles[index];

          return ListTile(
            title: Text(audioFile.name),
            subtitle: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.play_arrow),
                  onPressed: () {
                    playAudio(audioFile.path);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.pause),
                  onPressed: () {
                    pauseAudio();
                  },
                ),
                Expanded(
                  child: Slider(
                    onChanged: (double value) {
                      // Handle time bar/slider value change
                    },
                    min: 0.0,
                    max: 100.0,
                    value: 50.0, // Set initial value here
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    deleteFile(audioFile.path);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: AudioPlayerPage(),
  ));
}
