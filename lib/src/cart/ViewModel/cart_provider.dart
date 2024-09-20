import 'package:fashion_django/src/cart/models/cart_create_model.dart';
import 'package:fashion_django/src/cart/models/cart_model.dart';
import 'package:fashion_django/src/cart/models/cart_state.dart';
import 'package:fashion_django/src/cart/repository/cart_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final categoryRepository = CartRepository(http.Client());

class CartNotifier extends StateNotifier<CartState> {
  CartNotifier(this._cartRepository) : super(CartState()) {
    fetchAllCarts();
    fetchCartCount();
  }

  final CartRepository _cartRepository;

  void setCartList(List<CartModel> carts) {
    state = state.copyWith(carts: carts);
  }

  // void setCartCount( CartCountModel countModel) {
  //   state = state.copyWith(cartCountModel: countModel);
  // }

  Future<void> fetchAllCarts() async {
    state = state.copyWith(isLoading: true);
    try {
      final carts = await _cartRepository.getUserCart();
      setCartList(carts.cast<CartModel>());
    } catch (e) {
      print('Failed to fetch carts: $e');
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> addToCart(CartCreateModel newCart) async {
    await _cartRepository.addToCart(newCart);
    await fetchAllCarts();
  }

  Future<void> updateCartItemQuantity(int cartId, int quantity) async {
    await _cartRepository.updateCartItemQuantity(cartId, quantity);
    await fetchAllCarts();
  }

  Future<void> removeFromCart(int cartId) async {
    await _cartRepository.removeFromCart(cartId);
    await fetchAllCarts();
  }

  Future<void> fetchCartCount() async {
    try {
      final countModel = await _cartRepository.getCartCount();
      state = state.copyWith(cartCountModel: countModel);
      print("ddd");
    } catch (e) {
      print('Failed to fetch cart count: $e');
    }
  }
}

final cartNotifierProvider = StateNotifierProvider<CartNotifier, CartState>(
  (ref) => CartNotifier(categoryRepository),
);
