import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:news_apps/src/features/home/home.model.dart';
import 'package:news_apps/src/services/home.service.dart';

enum HomeStateStatus { Initialized, Loading, Success, Failed }

class HomeViewModel extends ChangeNotifier {
  bool _isLoading = false;
  HomeStateStatus _status = HomeStateStatus.Initialized;
  HomeServices _homeServices = new HomeServices();
  List<Article> _newsTopHeadline = [];

  bool get isLoading => _isLoading;
  HomeStateStatus get status => _status;
  List<Article> get newsTopHeadline => _newsTopHeadline;

  setStateStatus(HomeStateStatus status, bool loading) {
    _isLoading = loading;
    _status = status;
    notifyListeners();
  }

  getTopHeadlineNews() async {
    try {
      setStateStatus(HomeStateStatus.Loading, true);

      final response = await _homeServices.gettopHeadlineNews();

      final data = NewsTopHeadline.fromJson(response);

      _newsTopHeadline = data.articles.cast<Article>();

      setStateStatus(HomeStateStatus.Success, false);
    } on DioError catch (err) {
      if (err.type == DioErrorType.response) {
        if (err.response.statusCode == 400 || err.response.statusCode <= 409) {
          setStateStatus(HomeStateStatus.Failed, false);
          return err.response.data;
        } else if (err.response.statusCode >= 500) {
          setStateStatus(HomeStateStatus.Failed, false);
          return err.response.data;
        }
      } else if (err.type == DioErrorType.other) {
        if (err.message.contains('SocketException')) {
          setStateStatus(HomeStateStatus.Failed, false);
          return {'message': 'No internet connection / internal server error'};
        }
      }
    }
  }
}
