import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'CommunityScreen/com_main.dart';
import 'BaseScreen/base_screen.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late final SharedPreferences prefs;
  bool firstLogin = false;
  bool isLogin = false;

  Future initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    final log = prefs.getBool('FirstLogin');
    final nick = prefs.getString('Nickname');
    if (log != null) {
      if (nick != null) {
        if (log == true) {
          setState(() {
            firstLogin = true;
            CommunityMain.nickName = nick;
          });
        }
      }
    } else {
      setState(() {
        firstLogin = false;
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
    return Scaffold(
      body: isLogin
          ? const BaseScreen()
          : firstLogin
              ? afterlogin()
              : fisrtlogin(),
    );
  }

  Center afterlogin() {
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
                labelText: 'Password',
              )),
        ),
        const SizedBox(
          height: 20,
        ),
        ElevatedButton(
            onPressed: () {
              final password = prefs.getString('Password');
              if (password != null) {
                if (password == textController.text) {
                  setState(() {
                    isLogin = true;
                  });
                } else {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: const Text('Incorrect Password'),
                          actions: [
                            ElevatedButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: const Text('OK')),
                          ],
                        );
                      });
                }
              } else {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: const Text(
                            'Unable to get password information\nPlease launch the app again.'),
                        actions: [
                          ElevatedButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text('OK')),
                        ],
                      );
                    });
              }
            },
            child: const Text("Start")),
      ],
    ));
  }

  Center fisrtlogin() {
    final textNicknameController = TextEditingController();
    final textPasswordController = TextEditingController();

    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 300,
          child: TextField(
              controller: textNicknameController,
              maxLines: 1,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 15.0),
                border: const OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.purple.shade300),
                ),
                labelText: 'Nickname',
              )),
        ),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          width: 300,
          child: TextField(
              controller: textPasswordController,
              maxLines: 1,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 15.0),
                border: const OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.purple.shade300),
                ),
                labelText: 'Password',
              )),
        ),
        const SizedBox(
          height: 20,
        ),
        ElevatedButton(
            onPressed: () async {
              await prefs.setBool("FirstLogin", true);
              await prefs.setString("Nickname", textNicknameController.text);
              await prefs.setString("Password", textPasswordController.text);
              if (mounted) {
                setState(() {
                  CommunityMain.nickName = textNicknameController.text;
                  firstLogin = true;
                  isLogin = true;
                });
              }
            },
            child: const Text("Start")),
      ],
    ));
  }
}
