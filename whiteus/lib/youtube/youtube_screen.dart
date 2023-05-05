import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
//import 'package:retrofit_pkg/RestClient.dart';
import 'dart:developer';

import 'DataModel.dart';
import 'Player.dart';
import 'RestClient.dart';

void main() => runApp(const WidgetDemo());

class WidgetDemo extends StatefulWidget {
  const WidgetDemo({super.key});

  @override
  State<StatefulWidget> createState() => WidgetDemoState();
}

class WidgetDemoState extends State<WidgetDemo> {
  late VideoItems response;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Retrofit Demo',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Retrofit Demo'),
        ),
        body: getPage(),
      ),
    );
  }

  getData() {
    final dio = Dio();
    final client = RestClient(dio);
    client
        .getYouTubeAPI(
        "dyRsYk0LyA8",
        "AIzaSyAvmIOOgWdDr6dieGgUK40wuUjmV8i_nAA",
        "items(id,snippet(publishedAt,title,thumbnails),statistics(viewCount))",
        "snippet,statistics")
        .then((it) {
      setState(() {
        response = ((it['items'] as List)[0]) as VideoItems;
        isLoading = true;
        log(response.snippet.title);
      });
    });
  }

  Widget getPage() {
    late Widget page;
    if (!isLoading) {
      page = page0();
      getData();
    } else {
      page = page1();
    }
    return page;
  }

  Container page0() {
    return Container(
      alignment: Alignment.center,
      child: const Text(
        'Loading...',
        style: TextStyle(color: Colors.blue, fontSize: 30),
      ),
    );
  }

  ListView page1() {
    return ListView(
      children: <Widget>[
        ListTile(
          leading: Image.network(response.snippet.thumbnails.medium.url),
          title: Text(response.snippet.title),
          subtitle: Text('View : ${response.statistics.viewCount}'),
          trailing: const Icon(Icons.favorite_border),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Player('dyRsYk0LyA8',
                    response.snippet.title),
              ),
            );
          },
        ),
      ],
    );
  }
}
