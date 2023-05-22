import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:whiteus/CommunityScreen/com_main.dart';

class PostCard extends StatefulWidget {
  final String id, nickname, contents, datetime;
  final int recommendNum;
  const PostCard({
    super.key,
    required this.id,
    required this.nickname,
    required this.contents,
    required this.datetime,
    required this.recommendNum,
  });

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  late final IconButton _recBtn, _notRecBtn;

  @override
  initState() {
    super.initState();
    _recBtn = IconButton(
      onPressed: () {
        setState(() {
          FirebaseFirestore.instance
              .collection('Community')
              .doc(widget.id)
              .update({
            "recommendNum": widget.recommendNum - 1,
            "recommendList": FieldValue.arrayRemove([widget.nickname])
          });
        });
      },
      icon: const Icon(
        Icons.recommend_outlined,
        size: 20,
        color: Colors.green,
      ),
    );

    _notRecBtn = IconButton(
        onPressed: () {
          setState(() {
            FirebaseFirestore.instance
                .collection('Community')
                .doc(widget.id)
                .update({
              "recommendNum": widget.recommendNum + 1,
              "recommendList": FieldValue.arrayUnion([widget.nickname])
            });
          });
        },
        icon: const Icon(
          Icons.recommend_outlined,
          size: 20,
        ));
  }

  Future<bool> _returnIconBtn() async {
    dynamic nameList = await FirebaseFirestore.instance
        .collection('Community')
        .doc(widget.id)
        .get();

    if (nameList.data()['recommendList'].contains(CommunityMain.nickName)) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: Colors.blueGrey.shade300,
            height: 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                    "${DateTime.now().year}년 ${DateTime.now().month}월 ${DateTime.now().day}일"),
                Text(widget.nickname),
                const SizedBox(
                  width: 30,
                ),
                Row(
                  children: [
                    FutureBuilder(
                        future: _returnIconBtn(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return _notRecBtn;
                          } else if (snapshot.hasError) {
                            return const Text('?');
                          } else {
                            if (snapshot.data == true) {
                              return _recBtn;
                            } else {
                              return _notRecBtn;
                            }
                          }
                        }),
                    Text("${widget.recommendNum}"),
                  ],
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(5),
            color: Colors.white70,
            child: Text(
              widget.contents,
              style: const TextStyle(color: Colors.black, fontSize: 16),
            ),
          )
        ],
      ),
    );
  }
}
