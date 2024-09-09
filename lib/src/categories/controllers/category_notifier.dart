import 'package:flutter/cupertino.dart';

class CategoryNotifier extends ChangeNotifier {
  String categoryTitle = "";
  int _id = 0;
  int get id => _id;

  void setCategoryAndId({required String category, required int id}) {
    categoryTitle = category;
    _id = id;
    notifyListeners();
  }
}
