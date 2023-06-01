import 'package:flutter/material.dart';
import 'package:whiteus/widgets/youtube_widget.dart';
import 'package:whiteus/services/youtube_service.dart';

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

  List<String> sortedVideoIds = [];

  @override
  void initState() {
    super.initState();
    sortVideosByViewCount();
  }

  // 조회수로 비디오 정렬
  void sortVideosByViewCount() async {
    Map<String, int> viewCounts = {};

    for (String videoId in widget.videoIds) {
      var videoInfo = await fetchVideoInfo(videoId, 'AIzaSyAvmIOOgWdDr6dieGgUK40wuUjmV8i_nAA');
      viewCounts[videoId] = videoInfo['viewCount'];
    }

    sortedVideoIds = widget.videoIds
      ..sort((a, b) => (viewCounts[b] ?? 0).compareTo(viewCounts[a] ?? 0));

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF348AC7),
                  Color(0xFF7474BF),
                ],
              ),
            ),
          ),
          Column(
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
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: PageView(
                  controller: pageController,
                  onPageChanged: (page) {
                    if (mounted) {
                      setState(() {
                        showIcon = (page == 2 ? false : true);
                      });
                    }
                  },
                  children: sortedVideoIds
                      .asMap()
                      .entries
                      .map((entry) => Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Rank ${entry.key + 1}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 10,
                              offset: Offset(0, 5),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: YoutubeWidget(
                            videoId: entry.value,
                            key: Key(entry.value),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ))
                      .toList(),
                ),
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
              const SizedBox(height: 20), // 추가된 여백
            ],
          ),
        ],
      ),
    );
  }
}

// 각 화면 class 정의
class BabyScreen extends CardScreen {
  const BabyScreen({Key? key})
      : super(
    key: key,
    title: 'Baby',
    image: 'assets/images/baby.jpg',
    id: '1',
  );

  @override
  List<String> get videoIds => [
    '4owTdwvbyNA',
    'XgxRHa26JLo',
    'oewj_XEM1js',
    'W-vBu2rf8TI',
    'LdQJw5S4nAQ'
  ]; // 비디오 아이디 입력
}

class StudyScreen extends CardScreen {
  const StudyScreen({Key? key})
      : super(
    key: key,
    title: 'Study',
    image: 'assets/images/study.jpg',
    id: '2',
  );

  @override
  List<String> get videoIds => [
    '_4kHxtiuML0',
    'WPni755-Krg',
    'Jvgx5HHJ0qw',
    '1_G60OdEzXs',
    'wGdodz6ck7g'
  ];
}

class SleepScreen extends CardScreen {
  const SleepScreen({Key? key})
      : super(
    key: key,
    title: 'Sleep',
    image: 'assets/images/sleep.jpg',
    id: '3',
  );

  @override
  List<String> get videoIds => [
    '77ZozI0rw7w',
    'u5EWe5baBck',
    'm8VDZ-z8OKk',
    'bP9gMpl1gyQ',
    '1ZYbU82GVz4'
  ];
}

class MeditationScreen extends CardScreen {
  const MeditationScreen({Key? key})
      : super(
    key: key,
    title: 'Meditation',
    image: 'assets/images/meditation.jpg',
    id: '4',
  );

  @override
  List<String> get videoIds => [
    'FTqrQsSIKR0',
    'V1RPi2MYptM',
    'Ho91a_GwYxs',
    'aIIEI33EUqI',
    'Gqfk5sr9fpw'
  ];
}
