// import 'package:flutter/material.dart';
//
// class LocalScreen extends StatelessWidget {
//   const LocalScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         child: const Text("Local Screen"),
//       ),
//     );
//   }
// }
//

import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class MusicPlayer extends StatefulWidget {
  late String path;

  MusicPlayer({super.key});

  @override
  _MusicPlayerState createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<MusicPlayer> {
  AudioPlayer audioPlayer = AudioPlayer();
  List<FileSystemEntity> _files = [];

  bool isPlaying = false;
  Duration duration = const Duration();
  Duration position = const Duration();

  @override
  void initState() {
    super.initState();
    _loadFiles();
  }

void _loadFiles() async {
  List<String> assetPaths = <String>[
    'assets/Over_the_Horizon.mp3'
    // Add more MP3 file paths as needed
  ];

  List<File> mp3Files = [];

  for (String assetPath in assetPaths) {
    ByteData byteData = await rootBundle.load(assetPath);
    String fileName = assetPath.split('/').last;

    String tempDirPath = (await getTemporaryDirectory()).path;
    String filePath = '$tempDirPath/$fileName';

    File file = File(filePath);
    await file.writeAsBytes(byteData.buffer.asUint8List());

    mp3Files.add(file);
  }

  setState(() {
    _files = mp3Files;
  });
}

void _play(String filePath) async {
  await audioPlayer.setSource(AssetSource('Over_the_Horizon.mp3'));
 
}


  void _pause() async {
    await audioPlayer.pause();
    setState(() {
      isPlaying = false;
    });
  }

  void _stop() async {
    await audioPlayer.stop();
    setState(() {
      isPlaying = false;
    });
  }

  String _getDurationString(Duration duration) {
    return duration.toString().split('.').first.padLeft(8, "0");
  }

  Widget _buildMusicPlayer(BuildContext context, FileSystemEntity file) {
    return ListTile(
      leading: const Icon(Icons.music_note),
      title: Text(file.path.split('/').last),
      trailing: isPlaying
          ? IconButton(
        icon: const Icon(Icons.pause),
        onPressed: _pause,
      )
          : IconButton(
        icon: const Icon(Icons.play_arrow),
        onPressed: () => _play(file.path),
      ),
      subtitle: Slider(
        value: position.inSeconds.toDouble(),
        min: 0.0,
        max: duration.inSeconds.toDouble(),
        onChanged: (double value) {
          setState(() {
            audioPlayer.seek(Duration(seconds: value.toInt()));
            value = value;
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Music Player'),
      ),
      body: _files.isEmpty
          ? const Center(
        child: Text('No MP3 files found.'),
      )
          : ListView.builder(
        itemCount: _files.length,
        itemBuilder: (BuildContext context, int index) {
          return _buildMusicPlayer(context, _files[index]);
        },
      ),
    );
  }
}