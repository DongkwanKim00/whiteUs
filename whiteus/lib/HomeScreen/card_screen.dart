import 'package:flutter/material.dart';
import 'package:whiteus/widgets/youtube_widget.dart';

class CardScreen extends StatefulWidget {
  final String title, image, id;

  const CardScreen({
    Key? key,
    required this.title,
    required this.image,
    required this.id,
  }) : super(key: key);


  List<String> get videoIds => [];
  
  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  final PageController pageController = PageController();
  bool showIcon = true;


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[100],
      body: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Hero(
                  tag: widget.id,
                  child: Container( 
                    width: 60,
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
                    child: Image.asset(widget.image),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  "${widget.title} White Noise Playlist",
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w800),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: Stack(
              children: [
PageView(
  controller: pageController,
  onPageChanged: (page) {
    if (mounted) {
      setState(() {
        showIcon = (page == 2 ? false : true);
      });
    }
  },
  children: widget.videoIds  // changed from "videoIds" to "widget.videoIds"
    .map((id) => YoutubeWidget(
      videoId: id,
    ))
    .toList(),
),

                Visibility(
                  visible: showIcon,
                  child: const Positioned(
                    bottom: 30,
                    right: 20,
                    child: Icon(
                      Icons.arrow_circle_right_outlined,
                      size: 35,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class BabyScreen extends CardScreen {
  const BabyScreen({super.key})
      : super(
          title: 'Baby',
          image: 'lib/HomeScreen/image/baby.jpg', // Provide the correct path
          id: '1',
        );

  @override
  List<String> get videoIds => ['UTkTLmrWssk'];
  // Replace 'BabyVideoId...' with the actual video IDs
}

class StudyScreen extends CardScreen {
  const StudyScreen({super.key})
      : super(
          title: 'Study',
          image: 'lib/HomeScreen/image/study.jpg', // Provide the correct path
          id: '2',
        );

  @override
  List<String> get videoIds => ['StudyVideoId1', 'StudyVideoId2', 'StudyVideoId3'];
  // Replace 'StudyVideoId...' with the actual video IDs
}

class SleepScreen extends CardScreen {
  const SleepScreen({super.key})
      : super(
          title: 'Sleep',
          image: 'lib/HomeScreen/image/sleep.jpg', // Provide the correct path
          id: '3',
        );

  @override
  List<String> get videoIds => ['SleepVideoId1', 'SleepVideoId2', 'SleepVideoId3'];
  // Replace 'SleepVideoId...' with the actual video IDs
}

class MeditationScreen extends CardScreen {
  const MeditationScreen({super.key})
      : super(
          title: 'Meditation',
          image: 'lib/HomeScreen/image/meditation.jpg', // Provide the correct path
          id: '4',
        );

  @override
  List<String> get videoIds => ['MeditationVideoId1', 'MeditationVideoId2', 'MeditationVideoId3'];
  // Replace 'MeditationVideoId...' with the actual video IDs
}
