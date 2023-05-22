import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'com_main.dart';

class ComLogin extends StatefulWidget {
  const ComLogin({super.key});

  @override
  State<ComLogin> createState() => _ComLoginState();
}

class _ComLoginState extends State<ComLogin> {
  late final SharedPreferences prefs;
  String nickName = "";
  bool isLogin = true;

  Future initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    final log = prefs.getBool('Loginzx');
    final nick = prefs.getString('nickname');
    if (log != null) {
      if (nick != null) {
        if (log == true) {
          setState(() {
            isLogin = true;
            CommunityMain.nickName = nick;
          });
        }
      }
    } else {
      setState(() {
        isLogin = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    initPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return isLogin ? const CommunityMain() : comLogin();
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
              maxLines: 1,
              keyboardType: TextInputType.multiline,
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
              await prefs.setBool("Loginzx", true);
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
