import 'package:fashion_django/src/cart/models/cart_count_model.dart';
import 'package:fashion_django/src/cart/models/cart_model.dart';

class CartState {
  CartState({
    this.isLoading = false,
    List<CartModel>? carts,
    CartCountModel? cartCountModel,
  })  : carts = carts ?? [],
        cartCountModel = cartCountModel ?? CartCountModel(cartItemsCount: 0);

  final bool isLoading;
  final List<CartModel> carts;
  final CartCountModel cartCountModel;

  CartState copyWith({
    bool? isLoading,
    List<CartModel>? carts,
    CartCountModel? cartCountModel,
  }) {
    return CartState(
      isLoading: isLoading ?? this.isLoading,
      carts: carts ?? this.carts,
      cartCountModel: cartCountModel ?? this.cartCountModel,
    );
  }
}
