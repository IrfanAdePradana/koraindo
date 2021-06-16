import '../../utils/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class HomeServices {
  static final HomeServices _homeServices = HomeServices._internal();

  HomeServices._internal();

  factory HomeServices() {
    return _homeServices;
  }

  DioHttp client = DioHttp();

  gettopHeadlineNews() async {
    final response = await client.dio.get(
        "${env['BASE_URL']}/top-headlines?country=id&apiKey=${env['API_KEY']}");

    return response.data;
  }
}
