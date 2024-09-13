import 'package:fashion_django/src/categories/models/categories_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CatNotifier extends StateNotifier<CategoryModel> {
  CatNotifier(super.state);

  void setIdAndCsat(CategoryModel cat) {
    state = cat;
  }
}

final catNotifierProvider =
    StateNotifierProvider<CatNotifier, CategoryModel>((ref) => CatNotifier(CategoryModel.empty()));
