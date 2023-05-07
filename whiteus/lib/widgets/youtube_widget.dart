import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../services/youtube_service.dart';

class YoutubeWidget extends StatefulWidget {
  final String videoId;

  const YoutubeWidget({Key? key, required this.videoId}) : super(key: key);

  @override
  _YoutubeWidgetState createState() => _YoutubeWidgetState();
}

class _YoutubeWidgetState extends State<YoutubeWidget> {
  late YoutubePlayerController _controller;
  late Future<Map<String, dynamic>> videoInfo;
  bool _showPlayer = false;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
    videoInfo = fetchVideoInfo(
        widget.videoId, 'AIzaSyAvmIOOgWdDr6dieGgUK40wuUjmV8i_nAA');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onPlayButtonPressed() {
    setState(() {
      _showPlayer = true;
      _controller.play();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.5,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: Colors.white,
        elevation: 5,
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
                child: _showPlayer
                    ? AspectRatio(
                        aspectRatio: 16 / 9,
                        child: YoutubePlayer(
                          controller: _controller,
                          showVideoProgressIndicator: true,
                        ),
                      )
                    : InkWell(
                        onTap: _onPlayButtonPressed,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.network(
                              'https://img.youtube.com/vi/${widget.videoId}/hqdefault.jpg',
                              fit: BoxFit.contain,
                            ),
                            Positioned(
                              bottom: MediaQuery.of(context).size.height * 0.25,
                              left: 0,
                              right: 0,
                              child: const Center(
                                child: Icon(
                                  Icons.play_circle_outline,
                                  color: Colors.black,
                                  size: 64,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
              ),
            ),
            Expanded(
              flex: 1,
              child: FutureBuilder<Map<String, dynamic>>(
                future: videoInfo,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            snapshot.data!['title'],
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '조회수: ${snapshot.data!['viewCount']}',
                            style: const TextStyle(fontSize: 14),
                          ),
                        ],
                      );
                    } else {
                      return const Text('영상 정보를 불러오지 못했습니다.');
                    }
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
