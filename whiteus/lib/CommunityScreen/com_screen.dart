import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'com_main.dart';

class ComScreen extends StatefulWidget {
  const ComScreen({super.key});

  @override
  State<ComScreen> createState() => _ComScreenState();
}

class _ComScreenState extends State<ComScreen> {
  late final SharedPreferences prefs;
  late final String nickName;
  bool isLogin = false;

  Future initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    final log = prefs.getBool('Login');
    final nick = prefs.getString('nickname');
    if (log != null) {
      if (nick != null) {
        if (log == true) {
          setState(() {
            isLogin = true;
            nickName = nick;
          });
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    initPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLogin ? CommunityMain(nickName: nickName) : comLogin(),
    );
  }

  Center comLogin() {
    final textController = TextEditingController();

    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 300,
          child: TextField(
              controller: textController,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 15.0),
                border: const OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.purple.shade300),
                ),
                labelText: 'NickName',
              )),
        ),
        const SizedBox(
          height: 20,
        ),
        ElevatedButton(
            onPressed: () async {
              await prefs.setBool("Login", true);
              await prefs.setString("nickname", textController.text);
              if (mounted) {
                setState(() {
                  nickName = textController.text;
                  isLogin = true;
                });
              }
            },
            child: const Text("Start Commnuity")),
      ],
    ));
  }
}
