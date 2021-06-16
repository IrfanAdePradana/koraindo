import 'package:flutter/material.dart';

class MenuViewModel extends ChangeNotifier {
  int _indexMenu = 0;

  int get indexMenu => _indexMenu;

  setStateIndexMenu(int index) {
    _indexMenu = index;
    notifyListeners();
  }
}
