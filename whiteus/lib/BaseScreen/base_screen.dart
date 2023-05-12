import 'package:flutter/material.dart';
import 'package:whiteus/CommunityScreen/com_screen.dart';
import 'package:whiteus/HomeScreen/home_screen.dart';
import 'package:whiteus/LocalScreen/local_screen.dart';
import 'package:whiteus/StoreScreen/store_screen.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({super.key});

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

// 글자 형광펜 그은 것처럼 만들어 줌(형권)
class HighLightedText extends StatelessWidget {
  final String data;
  final Color color;
  final double fontSize;

  const HighLightedText(
      this.data, {
        super.key,
        required this.color,
        this.fontSize = 14,
      });

  Size getTextSize({
    required String text,
    required TextStyle style,
    required BuildContext context,
  }) {
    final Size size = (TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: 1,
      textScaleFactor: MediaQuery.of(context).textScaleFactor,
      textDirection: TextDirection.ltr,
    )..layout())
        .size;
    return size;
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = TextStyle(
      fontSize: fontSize,
      color: color,
      fontWeight: FontWeight.bold,
    );
    final Size textSize = getTextSize(
      text: data,
      style: textStyle,
      context: context,
    );
    return Stack(
      children: [
        Text(data, style: textStyle),
        Positioned(
          top: textSize.height / 2,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              color: color.withOpacity(0.5),
            ),
            height: textSize.height / 3,
            width: textSize.width,
          ),
        )
      ],
    );
  }
}

class _BaseScreenState extends State<BaseScreen> {
  int _selectedIndex = 0;
  static final List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    MusicPlayer(path: 'Over_the_Horizon.mp3'), //원래 LocalScreen
    const ComScreen(),
    Mp3UploaderDownloader(), //이거 수정했음. 원래 StoreScreen
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const HighLightedText(
          'WHITE US',
          color:Colors.white,
          fontSize:20,
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent, //투명으로 바꿈.
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Shopping cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.comment),
            label: 'Community',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.store),
            label: 'Store',
          ),
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        backgroundColor: Colors.transparent, //투명한게 깔끔해서 바꿈.
        onTap: _onItemTapped,
      ),
    );
  }
}
