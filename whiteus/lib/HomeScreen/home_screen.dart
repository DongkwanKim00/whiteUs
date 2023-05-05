import 'package:flutter/material.dart';
import 'card_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final List<String> imageTitle = ["Baby", "Study", "Sleep", "Meditation"];
  final List<String> imagePath = [
    "lib/HomeScreen/image/baby.jpg",
    "lib/HomeScreen/image/study.jpg",
    "lib/HomeScreen/image/sleep.jpg",
    "lib/HomeScreen/image/meditation.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Expanded(child: makePageView(imageTitle, imagePath)),
        ],
      ),
    );
  }
}

PageView makePageView(List<String> imageTitle, List<String> imagePath) {
  return PageView.builder(
    itemCount: imageTitle.length,
    controller: PageController(viewportFraction: 0.8),
    itemBuilder: (context, index) {
      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CardScreen(
                title: imageTitle[index],
                image: imagePath[index],
                id: index.toString(),
              ),
              fullscreenDialog: true,
            ),
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: index.toString(),
              child: Container(
                width: 250,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 15,
                      offset: const Offset(10, 10),
                      color: Colors.black.withOpacity(0.3),
                    )
                  ],
                ),
                child: Image.asset(imagePath[index]),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              imageTitle[index],
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
            ),
            
          ],
        ),
      );
    },
  );
}
