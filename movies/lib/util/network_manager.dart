import 'package:dio/dio.dart';

import 'constant.dart';

class NetworkManager {

  static const DefaultData = {};
  static const Apikey = '054022eaeae0b00e0fc068c0c0a2102a';
  static const BaseUrl = 'https://frodo.douban.com/api/v2';

  static get _dio => Dio(
      BaseOptions(
          baseUrl: BaseUrl,
      connectTimeout: 5000,
      receiveTimeout: 3000)
  );

  static Future<Response> get(String path, {String extra, Map<String, dynamic> data}) async {


    Map<String, dynamic> param = {'apikey': Apikey};

    param.addAll(data ?? {});

    if (path == Api.fetchMovie) {
      path += '/${param["id"]}';
    }

    path += extra ?? '';

    return await _dio.get(path, queryParameters: param);

  }


}