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
        title: new Text(
          "WHITE US",
          style: new TextStyle(
            fontWeight: FontWeight.w900,
            fontFamily: 'Handwriting',
            fontSize:60,
          ),
        ),
        centerTitle: true,
        // App bar gradient 효과 추가(형권)
        flexibleSpace: new Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[
                Color(0Xff7474BF),
                Color(0Xff348AC7),

              ],
            ),
          ),
        ),
        backgroundColor: Colors.transparent, //투명으로 바꿈.
      ),
      body: Center(
        child:Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin:Alignment.topRight,
              end: Alignment.bottomRight,
              colors: [
                Color(0Xff348AC7),
                Color(0Xff7474BF),
              ]
            )
          ),
          child: _widgetOptions.elementAt(_selectedIndex),
        )
      ),
      bottomNavigationBar: _createBottomNavigationBar(),
    );
  }

  // bottom navigation bar도 gradient효과 주려고 분리함(형권)
  Widget _createBottomNavigationBar(){
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0Xff7474BF),
            Color(0Xff348AC7),
          ],
          begin: Alignment.topLeft,
          end: Alignment.topRight,
          stops: [0.0, 0.8],
          tileMode: TileMode.clamp,
        ),
      ),

        child: BottomNavigationBar(
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
        selectedIconTheme: IconThemeData(color: Colors.amberAccent),
        unselectedIconTheme: IconThemeData(color: Colors.white),
      )
    );
  }



}
