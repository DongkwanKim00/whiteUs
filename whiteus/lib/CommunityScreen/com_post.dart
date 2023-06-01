import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:whiteus/CommunityScreen/com_main.dart';

class PostCard extends StatefulWidget {
  final String id, nickname, contents, datetime;
  final int recommendNum;

  const PostCard({
    Key? key,
    required this.id,
    required this.nickname,
    required this.contents,
    required this.datetime,
    required this.recommendNum,
  }) : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  late final IconButton _recBtn;
  late final IconButton _notRecBtn;

  @override
  void initState() {
    super.initState();
    _recBtn = IconButton(
      onPressed: () {
        setState(() {
          FirebaseFirestore.instance
              .collection('Community')
              .doc(widget.id)
              .update({
            "recommendNum": widget.recommendNum - 1,
            "recommendList": FieldValue.arrayRemove([CommunityMain.nickName])
          });
        });
      },
      icon: const Icon(
        Icons.thumb_up,
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
            "recommendList": FieldValue.arrayUnion([CommunityMain.nickName])
          });
        });
      },
      icon: const Icon(
        Icons.thumb_up_outlined,
        size: 20,
      ),
    );
  }

  Future<bool> _checkIfRecommended() async {
    final nameList = await FirebaseFirestore.instance
        .collection('Community')
        .doc(widget.id)
        .get();

    if (nameList.data()!['recommendList'].contains(CommunityMain.nickName)) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF6A85FF), Color(0xFF9346FF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade400,
            offset: Offset(0, 2),
            blurRadius: 4,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 30,
            color: Colors.indigoAccent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      widget.datetime,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '작성자:',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      widget.nickname,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    FutureBuilder(
                      future: _checkIfRecommended(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
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
                      },
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "${widget.recommendNum}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white, // 노란색 배경 색상
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              widget.contents,
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
