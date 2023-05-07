import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import '../widgets/youtube_widget.dart';

class CardScreen extends StatelessWidget {
  final String title, image, id;

  const CardScreen({
    Key? key,
    required this.title,
    required this.image,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> videoIds = [
      'I-TrcwHFsPw',
      'PwHlMZf_nNo',
      'Iwdq3NtpeFQ',
    ];

    return Scaffold(
      backgroundColor: Colors.blueGrey[100],
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height, // 화면 높이를 기반으로 이미지와 카드뉴스를 나눕니다.
              child: Center(
                child: Hero(
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
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height, // 카드뉴스 부분의 높이를 설정합니다.
              child: Swiper(
                itemBuilder: (BuildContext context, int index) {
                  return YoutubeWidget(videoId: videoIds[index]);
                },
                itemCount: videoIds.length,
                itemWidth: 300.0,
                layout: SwiperLayout.STACK,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
