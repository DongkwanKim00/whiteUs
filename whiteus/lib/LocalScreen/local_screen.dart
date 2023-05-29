import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class AudioFile {
  String name;
  String path;
  Duration duration = Duration.zero;

  AudioFile({required this.name, required this.path});
}

class AudioPlayerPage extends StatefulWidget {
  const AudioPlayerPage({super.key});

  @override
  _AudioPlayerPageState createState() => _AudioPlayerPageState();
}

class _AudioPlayerPageState extends State<AudioPlayerPage>
    with WidgetsBindingObserver {
  static const defaultPlayerCount = 1;  // 상수로 선언
  List<AudioPlayer> audioPlayers = List.generate(
    defaultPlayerCount,
    (_) => AudioPlayer()..setReleaseMode(ReleaseMode.stop),
  );
  int selectedPlayerIdx = 0;

  AudioPlayer get selectedAudioPlayer => audioPlayers[selectedPlayerIdx];
  List<AudioFile> audioFiles = [];
  Duration position = Duration.zero;

  @override
  void initState() {
    super.initState();
    loadAudioFiles();
    audioPlayer.onPositionChanged.listen((Duration p) {
      print('Current position: $p');
      setState(() => position = p);
    });
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

    if(mounted) {
      setState(() {});
    }
  }

  void playAudio(String path) async {
    await selectedAudioPlayer.play(UrlSource(path));
  }

  void pauseAudio() async {
    await selectedAudioPlayer.pause();
  }

  void deleteFile(String path) {
    File file = File(path);
    file.delete().then((_) {
      loadAudioFiles();
    });
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
    // for (var player in audioPlayers) {
    //   player.dispose();
    // }
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
                    value: position.inSeconds.toDouble(),
                    onChanged: (double value) {
                      // Handle time bar/slider value change
                      audioPlayer.seek(Duration(seconds: value.toInt()));
                    },
                    min: 0.0,
                    max: 100.0,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
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
