import 'package:cloud_firestore/cloud_firestore.dart';
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
        body: RefreshIndicator(
          onRefresh: () async {
            setState(() {});
          },
          child: Padding(
            padding:
                const EdgeInsets.only(left: 4, right: 4, top: 10, bottom: 10),
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('test').snapshots(),
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

                return ListView.separated(
                    scrollDirection: Axis.vertical,
                    itemCount: contents.length,
                    itemBuilder: (context, index) {
                      final content =
                          contents[index].data() as Map<String, dynamic>;

                      return PostCard(
                        nickname: content['name'],
                        contents: content['contents'],
                        datetime: content['time'],
                      );
                    },
                    separatorBuilder: (context, index) => Container());
              },
            ),
          ),
        ));
  }
}
