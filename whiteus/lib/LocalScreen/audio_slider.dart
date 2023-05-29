import 'package:audioplayers/audioplayers.dart';

class AudioPlayer {
  final AudioPlayer _player = AudioPlayer();

  Future<void> play(String path) async {
    await _player.play(path);
  }

  Future<void> pause() async {
    await _player.pause();
  }

  Future<void> setReleaseMode(ReleaseMode releaseMode) async {
    await _player.setReleaseMode(releaseMode);
  }

  void dispose() {
    _player.dispose();
  }
}

class AudioFile {
  final String name;
  final String path;

  AudioFile({required this.name, required this.path});
}
