import 'package:flutter/material.dart';
import 'package:medify/features/HeartAnaysis/ui/views/diseases_analysis.dart';
import 'package:medify/features/chat/ui/views/all_chats.dart';
import 'package:medify/features/doctors/ui/views/doc_view.dart';
import 'package:medify/features/notification/ui/views/notification_page.dart';
import 'package:medify/features/social/ui/views/socail_page.dart';

class tapProvider with ChangeNotifier {
  int _currentindex = 0;
  int get currentindex => _currentindex;

  List<Widget> get pages => [
        HeartAnalysisPage(),
        SocailPage(),
        DocsView(),
        AllChats(),
        NotificationView(),
      ];

  void updatecurrentindex(index) {
    _currentindex = index;
    notifyListeners();
  }
}
