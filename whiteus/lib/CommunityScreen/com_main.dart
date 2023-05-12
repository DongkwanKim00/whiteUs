import 'package:flutter/material.dart';
import 'package:whiteus/CommunityScreen/com_newpost.dart';
import 'com_post.dart';

class CommunityMain extends StatefulWidget {
  final String nickName;

  const CommunityMain({super.key, required this.nickName});

  @override
  State<CommunityMain> createState() => _CommunityMainState();
}

class _CommunityMainState extends State<CommunityMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue.shade200,
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isDismissible: true,
            builder: (_) => NewPost(
              name: widget.nickName,
            ),
            isScrollControlled: true,
          );
        },
        child: const Icon(Icons.add),
      ),
      body: PostCard(
        nickname: widget.nickName,
        contents: "안녕하세요 여러분, 이 사이트를 추천해 드립니다. \"www.youtube.com\\Dei239ss\"",
      ),
    );
  }
}
