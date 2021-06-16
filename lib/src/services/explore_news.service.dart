import '../../utils/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ExploreNewsService {
  static final ExploreNewsService _instance =
      new ExploreNewsService._internal();

  ExploreNewsService._internal();

  factory ExploreNewsService() {
    return _instance;
  }

  DioHttp _client = new DioHttp();

  Future getSearchNews(String searchKey) async {
    final response = await _client.dio.get("${env['BASE_URL']}/");

    return response.data;
  }

  Future getNewsByCategory(String category) async {
    final response = await _client.dio.get("${env['BASE_URL']}/");

    return response.data;
  }
}
