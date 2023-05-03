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
          Expanded(child: makeList(imageTitle, imagePath)),
          //Expanded(child: makeList(imageclass))
        ],
      ),
    );
  }
}

ListView makeList(List<String> imageTitle, List<String> imagePath) {
  return ListView.separated(
    scrollDirection: Axis.horizontal,
    itemCount: imageTitle.length,
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
    itemBuilder: (context, index) {
      //var image = imageclass[index];
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
    separatorBuilder: (context, index) => const SizedBox(width: 40),
  );
}
