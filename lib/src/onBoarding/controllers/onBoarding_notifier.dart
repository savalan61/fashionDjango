import 'package:flutter/cupertino.dart';

class OnBoardingNotifier extends ChangeNotifier {
  int _selectedPage = 0;

  int get selectedPage => _selectedPage;

  void setSelectedPage(int page) {
    _selectedPage = page;
    notifyListeners();
  }
}
