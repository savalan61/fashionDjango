import 'package:fashion_django/src/categories/models/categories_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CatNotifier extends StateNotifier<CategoryModel> {
  CatNotifier(super.state);

  void setIdAndCsat(CategoryModel cat) {
    state = cat;
    print(state.title);
  }
}

final catNotifierProvider =
    StateNotifierProvider<CatNotifier, CategoryModel>((ref) => CatNotifier(CategoryModel.empty()));

//--------------------------------------------------------------------------------------------

// class CatNotifier extends StateNotifier<List<CategoryModel>> {
//   CatNotifier() : super([]);
//
//   void setCategories(List<CategoryModel> categories) {
//     state = categories;
//   }
//
//   void setIdAndCat(CategoryModel cat) {
//     state = [
//       for (final item in state)
//         if (item.id == cat.id) cat else item,
//     ];
//   }
// }
//
// final catNotifierProvider = StateNotifierProvider<CatNotifier, List<CategoryModel>>((ref) => CatNotifier());
//
//
// final fetchCatProvider = FutureProvider<List<CategoryModel>>((ref) async {
//   const url = "http://10.0.2.2:8000/api/categories/";
//   final response = await http.get(Uri.parse(url));
//
//   if (response.statusCode == 200) {
//     final categories = categoriesFromJson(response.body);
//
//     // ذخیره داده‌ها در CatNotifier
//     ref.read(catNotifierProvider.notifier).setCategories(categories);
//
//     return categories;
//   } else {
//     throw Exception('Failed to load categories');
//   }
// });
