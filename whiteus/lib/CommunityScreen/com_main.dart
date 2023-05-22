import 'package:flutter/material.dart';
import 'package:whiteus/CommunityScreen/TapScreen/my_post.dart';
import 'package:whiteus/CommunityScreen/TapScreen/recommend_post.dart';
import 'package:whiteus/CommunityScreen/com_newpost.dart';
import 'TapScreen/all_post.dart';

class CommunityMain extends StatefulWidget {
  static String nickName = "";

  const CommunityMain({super.key});

  @override
  State<CommunityMain> createState() => _CommunityMainState();
}

class _CommunityMainState extends State<CommunityMain>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 3,
      vsync: this, //vsync에 this 형태로 전달해야 애니메이션이 정상 처리됨
    );
  }

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
              name: CommunityMain.nickName,
            ),
            isScrollControlled: true,
          );
        },
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(),
            ),
            child: TabBar(
              tabs: [
                _tapContainer(Icons.wechat),
                _tapContainer(Icons.account_box_rounded),
                _tapContainer(Icons.recommend),
              ],
              indicator: const BoxDecoration(
                gradient: LinearGradient(
                  //배경 그라데이션 적용
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Color(0Xff4776E6),
                    Color(0Xff8E54E9),
                  ],
                ),
              ),
              labelColor: Colors.white,
              unselectedLabelColor: Colors.black,
              controller: _tabController,
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                AllPostScreen(),
                MyPostScreen(),
                RecommendScreen(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Container _tapContainer(IconData icon) {
  return Container(
      height: 40,
      alignment: Alignment.center,
      child: Icon(
        icon,
        size: 26,
      ));
}
