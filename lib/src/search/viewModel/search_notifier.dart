import 'package:fashion_django/src/products/models/product_model.dart';
import 'package:fashion_django/src/search/repository/search_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchNotifier extends StateNotifier<List<ProductModel>> {
  SearchNotifier() : super([]);

  Future<void> setResults(String q) async {
    try {
      final List<ProductModel> prods = await SearchRepository().searchResult(q);
      state = prods;
    } catch (e) {
      state = [];
    }
  }
}

final searchProvider = StateNotifierProvider<SearchNotifier, List<ProductModel>>((ref) => SearchNotifier());

final fetchSearchProduct = FutureProvider.family<List<ProductModel>, String>((ref, q) async {
  await ref.read(searchProvider.notifier).setResults(q);
  return ref.read(searchProvider);
});
