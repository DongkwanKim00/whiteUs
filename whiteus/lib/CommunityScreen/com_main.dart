import 'package:flutter/material.dart';

class CommunityMain extends StatefulWidget {
  final String nickName;

  const CommunityMain({super.key, required this.nickName});

  @override
  State<CommunityMain> createState() => _CommunityMainState();
}

class _CommunityMainState extends State<CommunityMain> {
  @override
  Widget build(BuildContext context) {
    return Text(widget.nickName);
  }
}
