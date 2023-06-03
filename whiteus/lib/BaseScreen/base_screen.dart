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

class _BaseScreenState extends State<BaseScreen> {
  int _selectedIndex = 0;
  static final List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    // ignore: prefer_const_constructors
    AudioPlayerPage(),
    const ComScreen(),
    const Mp3UploaderDownloader(), //이거 수정했음. 원래 StoreScreen
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
        title: const Text(
          'White Us',
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontFamily: 'HandWriting',
            fontSize: 60,
          ),
        ),
        centerTitle: true,
        // App bar gradient(형권)
        flexibleSpace: Container(
          decoration: const BoxDecoration(
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
        backgroundColor: Colors.transparent, //지워야됨(형권)
      ),
      //이 부분 gradient가 잘 안되는 상황임.(형권)
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomRight,
            colors: [
              Color(0Xff348AC7),
              Color(0Xff7474BF),
            ],
          ),
        ),
        child: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
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
              label: 'HOME',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: 'SHOPPING CART',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.comment),
              label: 'COMMUNITY',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.store),
              label: 'STORE',
            ),
          ],
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          backgroundColor: Colors.transparent, //투명한게 깔끔해서 바꿈.
          onTap: _onItemTapped,
          selectedIconTheme: const IconThemeData(color: Colors.amberAccent),
          unselectedIconTheme: const IconThemeData(color: Colors.white),
          selectedLabelStyle: const TextStyle(
            fontFamily: 'HandWriting',
            fontSize: 18,
          ),
          unselectedLabelStyle: const TextStyle(
            fontFamily: 'HandWriting',
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
