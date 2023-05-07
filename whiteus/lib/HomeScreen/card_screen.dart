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

  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  final PageController pageController = PageController();
  bool showIcon = true;

  List<String> videoIds = [
    'I-TrcwHFsPw',
    'PwHlMZf_nNo',
    'Iwdq3NtpeFQ',
  ];

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
                    width: 50,
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
                  children: videoIds
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
