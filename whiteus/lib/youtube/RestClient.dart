import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'DataModel.dart';

part 'RestClient.g.dart';

@RestApi(baseUrl: "https://www.googleapis.com/youtube/v3")
abstract class RestClient{
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET("/videos")
  Future<Map<String, List<VideoItems>>> getYouTubeAPI(
      @Query("id") String videoId,
      @Query("key") String devKey,
      @Query("fields") String fields,
      @Query("part") String part);

}