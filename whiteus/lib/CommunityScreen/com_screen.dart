import 'package:flutter/material.dart';
import 'package:whiteus/CommunityScreen/com_main.dart';

class ComScreen extends StatefulWidget {
  const ComScreen({super.key});

  @override
  State<ComScreen> createState() => _ComScreenState();
}

class _ComScreenState extends State<ComScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CommunityMain(),
    );
  }
}
