import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class tapProvider with ChangeNotifier {
  int _currentindex = 0;
  int get currentindex => _currentindex;
  void updatecurrentindex(index) {
    _currentindex = index;
    notifyListeners();
  }
}
