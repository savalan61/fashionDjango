import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../../../common/utils/environment.dart';
import '../models/categories_model.dart';

class CatsNotifier extends StateNotifier<List<CategoryModel>> {
  CatsNotifier(super.state);

  void setCategories(List<CategoryModel> cats) {
    state = cats;
  }
}

final catsNotifierProvider = StateNotifierProvider<CatsNotifier, List<CategoryModel>>(
  (ref) => CatsNotifier([]),
);

final fetchCatProvider = FutureProvider<List<CategoryModel>>((ref) async {
  var url = "${Environment.appBaseUrl}/api/categories/";
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final categories = categoriesFromJson(response.body);
    ref.read(catsNotifierProvider.notifier).setCategories(categories);
    return categories;
  } else {
    throw Exception('Failed to load categories');
  }
});
