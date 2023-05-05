import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> fetchVideoInfo(
    String videoId, String apiKey) async {
  final url =
      'https://www.googleapis.com/youtube/v3/videos?part=snippet,statistics&id=$videoId&key=$apiKey';
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    var data = jsonDecode(response.body);
    var video = data['items'][0];
    String title = video['snippet']['title'];
    int viewCount = int.parse(video['statistics']['viewCount']);

    return {'title': title, 'viewCount': viewCount};
  } else {
    throw Exception('Failed to load video info');
  }
}
