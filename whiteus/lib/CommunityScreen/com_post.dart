import 'package:flutter/material.dart';

class PostCard extends StatelessWidget {
  final String nickname, contents, datetime;
  const PostCard(
      {super.key,
      required this.nickname,
      required this.contents,
      required this.datetime});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: Colors.blueGrey.shade300,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                    "${DateTime.now().year}년 ${DateTime.now().month}월 ${DateTime.now().day}일"),
                Text("작성자 $nickname"),
                SizedBox(
                  height: 36,
                  child: IconButton(
                      iconSize: 25,
                      onPressed: () {},
                      icon: const Icon(
                        Icons.add_box_outlined,
                        //size: 30,
                      )),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(5),
            color: Colors.white70,
            child: Text(
              contents,
              style: const TextStyle(color: Colors.black, fontSize: 16),
            ),
          )
        ],
      ),
    );
  }
}
