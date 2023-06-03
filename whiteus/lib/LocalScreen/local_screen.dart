import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';

class AudioFile {
  String name;
  String path;
  AudioPlayer audioPlayer;
  Duration totalDuration = Duration.zero;
  Duration currentPosition = Duration.zero;

  AudioFile(
      {required this.name, required this.path, required this.audioPlayer});
}

class AudioPlayerPage extends StatefulWidget {
  const AudioPlayerPage({Key? key}) : super(key: key);

  @override
  _AudioPlayerPageState createState() => _AudioPlayerPageState();
}

class _AudioPlayerPageState extends State<AudioPlayerPage>
    with WidgetsBindingObserver {
  List<AudioFile> audioFiles = [];
  Timer? positionTimer;
  AudioPlayer? currentAudioPlayer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    loadAudioFiles();
  }

  @override
  void dispose() {
    stopPositionTimer();
    for (var audioFile in audioFiles) {
      audioFile.audioPlayer.dispose();
    }
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      if (currentAudioPlayer != null) {
        pauseAudio(currentAudioPlayer!);
      }
    }
  }

  Future<void> loadAudioFiles() async {
    Directory directory =
        Directory('/data/user/0/com.example.whiteus/app_flutter/');
    List<FileSystemEntity> files = directory.listSync();

    audioFiles.clear();

    for (var file in files) {
      if (file.path.endsWith('.mp3')) {
        String fileName = file.path.split('/').last;
        AudioPlayer audioPlayer = AudioPlayer()
          ..setReleaseMode(ReleaseMode.stop);

        audioPlayer.onDurationChanged.listen((Duration d) {
          setState(() {
            audioFiles
                .firstWhere((element) => element.audioPlayer == audioPlayer)
                .totalDuration = d;
          });
        });

        audioFiles.add(AudioFile(
            name: fileName, path: file.path, audioPlayer: audioPlayer));
      }
    }

    setState(() {});
  }

  void playAudio(AudioPlayer audioPlayer, String path) async {
    await audioPlayer.play(UrlSource(path));
    currentAudioPlayer = audioPlayer;
    startPositionTimer(audioPlayer);
  }

  void pauseAudio(AudioPlayer audioPlayer) async {
    await audioPlayer.pause();
    stopPositionTimer();
    currentAudioPlayer = null;
  }

  void seekAudio(AudioPlayer audioPlayer, Duration duration) async {
    await audioPlayer.seek(duration);
  }

  void deleteFile(String path) {
    File file = File(path);
    file.delete().then((_) {
      loadAudioFiles();
    });
  }

  void startPositionTimer(AudioPlayer audioPlayer) {
    positionTimer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      audioPlayer.getCurrentPosition().then((Duration? position) {
        if (position != null) {
          setState(() {
            audioFiles
                .firstWhere((element) => element.audioPlayer == audioPlayer)
                .currentPosition = position;
          });
        }
      });
    });
  }

  void stopPositionTimer() {
    positionTimer?.cancel();
    positionTimer = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Audio Player'),
      // ),
      body: ListView.builder(
        itemCount: audioFiles.length,
        itemBuilder: (context, index) {
          AudioFile audioFile = audioFiles[index];

          return Container(
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
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
                audioFile.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              leading: const Icon(Icons.music_note, color: Colors.white),
              subtitle: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.play_arrow, color: Colors.white),
                    onPressed: () {
                      playAudio(audioFile.audioPlayer, audioFile.path);
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.pause, color: Colors.white),
                    onPressed: () {
                      pauseAudio(audioFile.audioPlayer);
                    },
                  ),
                  Expanded(
                    child: Slider(
                      onChanged: (double value) {
                        int millis =
                            (audioFile.totalDuration.inMilliseconds * value)
                                .round();
                        seekAudio(audioFile.audioPlayer,
                            Duration(milliseconds: millis));
                      },
                      min: 0.0,
                      max: 1.0,
                      value: audioFile.totalDuration.inMilliseconds > 0
                          ? audioFile.currentPosition.inMilliseconds /
                              audioFile.totalDuration.inMilliseconds
                          : 0.0,
                      activeColor: Colors.white,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.white),
                    onPressed: () {
                      deleteFile(audioFile.path);
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
