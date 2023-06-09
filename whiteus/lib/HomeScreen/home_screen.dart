import 'package:flutter/material.dart';
import 'card_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final List<String> imageTitle = ["Baby", "Study", "Sleep", "Meditation"];
  final List<String> imagePath = [
    "assets/images/baby.jpg",
    "assets/images/study.jpg",
    "assets/images/sleep.jpg",
    "assets/images/meditation.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 100,
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
          Widget screen;
          switch (imageTitle[index]) {
            case 'Baby':
              screen = const BabyScreen();
              break;
            case 'Study':
              screen = const StudyScreen();
              break;
            case 'Sleep':
              screen = const SleepScreen();
              break;
            case 'Meditation':
              screen = const MeditationScreen();
              break;
            default:
              screen = CardScreen(
                title: imageTitle[index],
                image: imagePath[index],
                id: index.toString(),
              );
          }
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => screen,
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
                    ),
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
              style: const TextStyle(
                  fontSize: 40,
                  fontFamily: 'HandWriting',
                  fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
      );
    },
  );
}

