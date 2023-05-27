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

//조회수로 비디오 정렬
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
                  children: sortedVideoIds
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

//각 화면 class 정의
class BabyScreen extends CardScreen {
  const BabyScreen({super.key})
      : super(
          title: 'Baby',
          image: 'lib/HomeScreen/image/baby.jpg', 
          id: '1',
        );

  @override
  List<String> get videoIds => ['4owTdwvbyNA', 'XgxRHa26JLo', 'oewj_XEM1js', 'W-vBu2rf8TI', 'LdQJw5S4nAQ']; //비디오 아이디 입력
}



class StudyScreen extends CardScreen {
  const StudyScreen({super.key})
      : super(
          title: 'Study',
          image: 'lib/HomeScreen/image/study.jpg', 
          id: '2',
        );

  @override
  List<String> get videoIds =>['_4kHxtiuML0', 'WPni755-Krg', 'Jvgx5HHJ0qw','1_G60OdEzXs','wGdodz6ck7g'];
}


class SleepScreen extends CardScreen {
  const SleepScreen({super.key})
      : super(
          title: 'Sleep',
          image: 'lib/HomeScreen/image/sleep.jpg', 
          id: '3',
        );

  @override
  List<String> get videoIds =>['77ZozI0rw7w', 'u5EWe5baBck', 'm8VDZ-z8OKk','bP9gMpl1gyQ','1ZYbU82GVz4'];
}


class MeditationScreen extends CardScreen {
  const MeditationScreen({super.key})
      : super(
          title: 'Meditation',
          image:
              'lib/HomeScreen/image/meditation.jpg', 
          id: '4',
        );

  @override
  List<String> get videoIds =>['FTqrQsSIKR0', 'V1RPi2MYptM', 'Ho91a_GwYxs','aIIEI33EUqI','Gqfk5sr9fpw'];
}