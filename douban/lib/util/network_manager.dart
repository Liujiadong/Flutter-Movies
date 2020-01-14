import 'package:dio/dio.dart';

class NetworkManager {

  static const DefaultData = {};
  static const Apikey = '0df993c66c0c636e29ecbb5344252a4a';
  static const City = '深圳';
  static const BaseUrl = 'https://api.douban.com';

  static get _dio => Dio(
      BaseOptions(
          baseUrl: BaseUrl,
      connectTimeout: 5000,
      receiveTimeout: 3000)
  );

  static Future<Response> get(String path, {Map<String, dynamic> data}) async {

    data['apikey'] = Apikey;
    data['city'] = City;

    return await _dio.get(path, queryParameters: data);

  }


}