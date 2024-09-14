import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../models/categories_model.dart';
import '../repository/category_repository.dart';

// Define the repository as a singleton or create it directly
final categoryRepository = CategoryRepository(http.Client());

// StateNotifier
class CatsNotifier extends StateNotifier<List<CategoryModel>> {
  CatsNotifier(this._repository) : super([]);
  final CategoryRepository _repository;

  /// Set All Categories
  void setCategories(List<CategoryModel> cats) {
    state = cats;
  }

  /// Set Top5 Categories
  void setTopCategories(List<CategoryModel> cats) {
    state = cats;
  }

  /// Fetch All Categories
  Future<void> fetchAllCategories() async {
    final categories = await _repository.fetchAllCategories();
    setCategories(categories);
  }

  /// Fetch Top5 Categories
  Future<void> fetchTopCategories() async {
    final categories = await _repository.fetchTopCategories();
    setTopCategories(categories);
  }
}

// StateNotifier Provider
final catsNotifierProvider = StateNotifierProvider<CatsNotifier, List<CategoryModel>>(
  (ref) => CatsNotifier(categoryRepository),
);

// Fetch Providers
final fetchAllCatsProvider = FutureProvider<List<CategoryModel>>((ref) async {
  await ref.read(catsNotifierProvider.notifier).fetchAllCategories();
  final List<CategoryModel> cats = ref.read(catsNotifierProvider);
  return cats;
});

final fetchTopCatsProvider = FutureProvider<List<CategoryModel>>((ref) async {
  await ref.read(catsNotifierProvider.notifier).fetchTopCategories();
  final List<CategoryModel> cats = ref.read(catsNotifierProvider);
  return cats;
});
