import 'package:flutter/widgets.dart';

class BottomTabNotifier extends ChangeNotifier {
  int _selectedTab = 0;
  int get selectedTab => _selectedTab;

  void setTabIndex(int index) {
    _selectedTab = index;
    notifyListeners();
  }
}
