import 'package:dio/dio.dart';

class dioHelper {
  static late Dio dio;
  static int() {
    dio = Dio(BaseOptions(
      baseUrl: 'https://academy2022.nitg-eg.com/',
      receiveDataWhenStatusError: true,
    ));
  }

  static Future<Response> getdata({
    required String url,
    Map<String, dynamic>? quary,
    String lang = 'en',
    String? token,
  }) async {
    dio.options.headers = {'Authorization': token};
    return await dio.get(url, queryParameters: quary);
  }

  static Future<Response> postdata({
    required String url,
    Map<String, dynamic>? quary,
    required Map<String, dynamic>? data,
    String lang = 'en',
    String? token,
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization': token
    };
    return dio.post(url, queryParameters: quary, data: data);
  }

  static Future<Response> putdata({
    required String url,
    Map<String, dynamic>? quary,
    required Map<String, dynamic>? data,
    String lang = 'en',
    String? token,
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization': token
    };
    return dio.put(url, queryParameters: quary, data: data);
  }
}
