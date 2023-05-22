import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:whiteus/CommunityScreen/com_main.dart';
import 'package:whiteus/CommunityScreen/com_post.dart';

class RecommendScreen extends StatefulWidget {
  const RecommendScreen({super.key});

  @override
  State<RecommendScreen> createState() => _RecommendScreenState();
}

class _RecommendScreenState extends State<RecommendScreen> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        setState(() {});
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 4, right: 4, top: 10, bottom: 10),
        child: FutureBuilder<QuerySnapshot>(
          future: FirebaseFirestore.instance
              .collection('Community')
              .where('recommendList', arrayContains: CommunityMain.nickName)
              .get(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Text("정보 불러오기 실패"),
              );
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            final contents = snapshot.data!.docs;

            return ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: contents.length,
              itemBuilder: (context, index) {
                final content = contents[index].data() as Map<String, dynamic>;

                return PostCard(
                  id: contents[index].id,
                  nickname: content['name'],
                  contents: content['contents'],
                  datetime: content['time'],
                  recommendNum: content['recommendNum'],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
