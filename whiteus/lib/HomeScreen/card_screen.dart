import 'package:flutter/material.dart';

import '../widgets/youtube_video_player.dart';

class CardScreen extends StatelessWidget {
  final String title, image, id;
  const CardScreen({
    super.key,
    required this.title,
    required this.image,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[100],
      body: Column(
        children: [
          const SizedBox(
            height: 100,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: id,
                child: Container(
                  width: 250,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 15,
                        offset: const Offset(10, 10),
                        color: Colors.blueGrey.shade500,
                      )
                    ],
                  ),
                  child: Image.asset(image),
                ),
              ),
            ],
          ),
          const YouTubeVideoPlayer(videoId: 'I-TrcwHFsPw'),
        ],
      ),
    );
  }
}
