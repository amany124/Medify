import 'package:flutter/material.dart';

class tapProvider with ChangeNotifier {
  int _currentindex = 0;
  int get currentindex => _currentindex;
  void updatecurrentindex(index) {
    _currentindex = index;
    notifyListeners();
  }
}
