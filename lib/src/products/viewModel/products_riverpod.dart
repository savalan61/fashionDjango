import 'package:fashion_django/src/products/models/product_model.dart';
import 'package:fashion_django/src/products/repository/product_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

// Repository Provider
final prodRepositoryProvider = Provider<ProductRepository>(
  (ref) => ProductRepository(http.Client()),
);

class ProductsNotifier extends StateNotifier<List<ProductModel>> {
  ProductsNotifier(this._productRepository) : super([]);
  final ProductRepository _productRepository;

  void setProds(List<ProductModel> prods) {
    state = prods;
  }

  Future<void> fetchAllProducts() async {
    final allProducts = await _productRepository.fetchAllProducts();
    setProds(allProducts);
  }

  Future<void> fetchProductsByClothesType(String clothesType) async {
    final products = await _productRepository.fetchProductsByClothesType(clothesType);
    setProds(products);
  }
}

// StateNotifier Provider
final prodsNotifierProvider = StateNotifierProvider<ProductsNotifier, List<ProductModel>>(
  (ref) => ProductsNotifier(ref.read(prodRepositoryProvider)),
);

// Fetch Providers
final fetchAllProdsProvider = FutureProvider<List<ProductModel>>((ref) async {
  await ref.read(prodsNotifierProvider.notifier).fetchAllProducts();
  return ref.read(prodsNotifierProvider);
});

final fetchProductsByClothesTypeProvider = FutureProvider.family<List<ProductModel>, String>((ref, clothesType) async {
  await ref.read(prodsNotifierProvider.notifier).fetchProductsByClothesType(clothesType);
  return ref.read(prodsNotifierProvider);
});
