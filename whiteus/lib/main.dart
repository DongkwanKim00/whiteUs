import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:whiteus/login.dart';
import 'package:flutter/services.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const String _title = 'ASMR App';

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: _title,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color.fromRGBO(40, 44, 55, 1),
        scaffoldBackgroundColor: const Color.fromRGBO(14, 14, 15, 0),
        fontFamily: "SUIT",
        textTheme: const TextTheme(
          displayLarge: TextStyle(
              fontSize: 72.0,
              fontWeight: FontWeight.bold,
              color: Colors.white70),
          titleLarge: TextStyle(
              fontSize: 36.0,
              fontStyle: FontStyle.italic,
              color: Colors.white70),
          bodyMedium: TextStyle(
              fontSize: 14.0, fontFamily: 'Hind', color: Colors.white70),
        ),
        colorScheme: const ColorScheme.dark()
            .copyWith(
              secondary: const Color.fromRGBO(80, 84, 95, 1),
              onSecondary: Colors.white, // 선택되지 않은 항목의 색상
            )
            .copyWith(background: const Color.fromRGBO(55, 48, 107, 1)),
      ),
      home: const Login(),
    );
  }
}
