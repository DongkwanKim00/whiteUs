
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class AudioFile {
  String name;
  String path;

  AudioFile({required this.name, required this.path});
}


class AudioPlayerPage extends StatefulWidget {
  const AudioPlayerPage({super.key});

  @override

  _AudioPlayerPageState createState() => _AudioPlayerPageState();
}

// class _AudioPlayerPageState extends State<AudioPlayerPage> {
class _AudioPlayerPageState extends State<AudioPlayerPage> with WidgetsBindingObserver {
  late AudioPlayer audioPlayer;
  List<AudioFile> audioFiles = [];


  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();
    loadAudioFiles();
  }


  Future<void> loadAudioFiles() async {
    Directory directory = Directory('/data/user/0/com.example.whiteus/app_flutter/');
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

  void playAudio(String path) async {
   
    await audioPlayer.play(UrlSource(path));
  }

  void pauseAudio() async {
    await audioPlayer.pause();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive || state == AppLifecycleState.paused) {
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

        title: const Text('오디오 플레이어'),
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
                  icon: const Icon(Icons.play_arrow),
                  onPressed: () {
                    playAudio(audioFile.path);
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.pause),
                  onPressed: () {
                    pauseAudio();
                  },
                ),
                Expanded(
                  child: Slider(
                    onChanged: (double value) {
                      // 시간 막대 값 변경 처리
                    },
                    min: 0.0,
                    max: 100.0,
                    value: 50.0, // 초기 값을 여기서 설정
                  ),
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
  runApp(const MaterialApp(
    home: AudioPlayerPage(),
  ));
}
