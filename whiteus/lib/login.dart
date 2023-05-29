import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whiteus/BaseScreen/base_screen.dart';
import 'CommunityScreen/com_main.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
    return isLogin ? const BaseScreen() : const Login();
  }

  Center login() {
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
