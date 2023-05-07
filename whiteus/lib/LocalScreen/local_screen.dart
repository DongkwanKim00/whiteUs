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

import 'dart:async';
import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class MusicPlayer extends StatefulWidget {
  final String path;

  MusicPlayer({required this.path});

  @override
  _MusicPlayerState createState() => new _MusicPlayerState();
}

class _MusicPlayerState extends State<MusicPlayer> {
  AudioPlayer audioPlayer = new AudioPlayer();
  List<FileSystemEntity> _files = [];

  bool isPlaying = false;
  Duration duration = new Duration();
  Duration position = new Duration();

  @override
  void initState() {
    super.initState();
    _loadFiles();
  }

  void _loadFiles() async {
    final directory = new Directory(widget.path);
    List<FileSystemEntity> files = directory.listSync();

    setState(() {
      _files = files.where((file) => file.path.endsWith('.mp3')).toList();
    });
  }

  void _play(String filePath) async {
    await audioPlayer.play(filePath as Source); //이부분 원래 그냥 filePath였는데 오류나서 자동 수정 해봄.
    setState(() {
      isPlaying = true;
    });
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
      leading: Icon(Icons.music_note),
      title: Text(file.path.split('/').last),
      trailing: isPlaying
          ? IconButton(
        icon: Icon(Icons.pause),
        onPressed: _pause,
      )
          : IconButton(
        icon: Icon(Icons.play_arrow),
        onPressed: () => _play(file.path),
      ),
      subtitle: Slider(
        value: position.inSeconds.toDouble(),
        min: 0.0,
        max: duration.inSeconds.toDouble(),
        onChanged: (double value) {
          setState(() {
            audioPlayer.seek(new Duration(seconds: value.toInt()));
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
        title: Text('Music Player'),
      ),
      body: _files.length == 0
          ? Center(
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