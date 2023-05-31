import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'CommunityScreen/com_main.dart';
import 'BaseScreen/base_screen.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late final SharedPreferences prefs;
  bool firstLogin = false;
  bool isLogin = false;

  Future<void> initPrefs() async {
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
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0Xff7474BF), // 그라디언트 시작 색상
              Color(0Xff348AC7), // 그라디언트 종료 색상
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: isLogin
            ? const BaseScreen()
            : firstLogin
            ? afterLogin()
            : firstLoginScreen(),
      ),
    );
  }

  Center afterLogin() {
    final textController = TextEditingController();

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Welcome to white us',
            style: TextStyle(
              fontSize: 30,
              fontFamily: 'HandWriting',
              color: Colors.white,
            ),
          ),
          SizedBox(
            width: 300,
            child: TextField(
              controller: textController,
              maxLines: 1,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 15.0,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white), // 테두리 색상 변경
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white), // 테두리 색상 변경
                ),
                labelText: 'Password',
                labelStyle: TextStyle(color: Colors.white), // 라벨 색상 변경
              ),
            ),
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
                            child: const Text('OK'),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white, // 버튼 색상 변경
                            ),
                          ),
                        ],
                      );
                    },
                  );
                }
              } else {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: const Text(
                        'Unable to get password information\nPlease launch the app again.',
                      ),
                      actions: [
                        ElevatedButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('OK'),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white, // 버튼 색상 변경
                          ),
                        ),
                      ],
                    );
                  },
                );
              }
            },
            child: const Text(
              "Start",
              style: TextStyle(color: Colors.black), // 버튼 텍스트 색상 변경
            ),
            style: ElevatedButton.styleFrom(
              primary: Colors.white, // 버튼 색상 변경
            ),
          ),
        ],
      ),
    );
  }

  Center firstLoginScreen() {
    final textNicknameController = TextEditingController();
    final textPasswordController = TextEditingController();

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Welcome to White us',
            style: TextStyle(
              fontSize: 30,
              fontFamily: 'HandWriting',
              color: Colors.white,
            ),
          ),
          SizedBox(
            width: 300,
            child: TextField(
              controller: textNicknameController,
              maxLines: 1,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 15.0,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white), // 테두리 색상 변경
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white), // 테두리 색상 변경
                ),
                labelText: 'Nickname',
                labelStyle: TextStyle(color: Colors.white), // 라벨 색상 변경
              ),
            ),
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
                  vertical: 10.0,
                  horizontal: 15.0,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white), // 테두리 색상 변경
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white), // 테두리 색상 변경
                ),
                labelText: 'Password',
                labelStyle: TextStyle(color: Colors.white), // 라벨 색상 변경
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () async {
              await prefs.setBool("FirstLogin", true);
              await prefs.setString(
                "Nickname",
                textNicknameController.text,
              );
              await prefs.setString(
                "Password",
                textPasswordController.text,
              );
              if (mounted) {
                setState(() {
                  CommunityMain.nickName = textNicknameController.text;
                  firstLogin = true;
                  isLogin = true;
                });
              }
            },
            child: const Text(
              "Start",
              style: TextStyle(color: Colors.black), // 버튼 텍스트 색상 변경
            ),
            style: ElevatedButton.styleFrom(
              primary: Colors.white, // 버튼 색상 변경
            ),
          ),
        ],
      ),
    );
  }
}
