import 'package:dio/dio.dart';

class DioHttp {
  static final DioHttp _intanceDioHttp = DioHttp._internal();

  DioHttp._internal();

  factory DioHttp() {
    return _intanceDioHttp;
  }

  Dio get dio => Dio(BaseOptions(
    baseUrl: 'https://newsapi.org/v2/',
  ));

}
