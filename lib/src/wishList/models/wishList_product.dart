import '../../products/models/product_model.dart';

class WishListModel {
  // Empty constructor
  factory WishListModel.empty() {
    return WishListModel(
      products: [],
      isLoading: false,
      errorMessage: null,
    );
  }

  WishListModel({
    required this.products,
    this.isLoading = false,
    this.errorMessage,
  });

  final List<WishListProduct> products;
  final bool isLoading;
  final String? errorMessage;

  // Method to copy with updated values
  WishListModel copyWith({
    List<WishListProduct>? products,
    bool? isLoading,
    String? errorMessage,
  }) {
    return WishListModel(
      products: products ?? this.products,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class WishListProduct {
  WishListProduct({
    required this.product,
    required this.isWished,
  });

  final ProductModel product;
  final bool isWished;
}
