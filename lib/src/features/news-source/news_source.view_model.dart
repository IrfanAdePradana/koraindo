import 'package:flutter/material.dart';

class NewsSourceViewModel extends ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  setStateLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }
}
