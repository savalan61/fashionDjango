// // ignore_for_file: prefer_const_constructors
//
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:fashion_django/common/utils/kcolors.dart';
// import 'package:fashion_django/const/constants.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// class CartTile extends StatelessWidget {
//   const CartTile({required this.cart, super.key, this.onDelete, this.onUpdate});
//   final CartModel cart;
//   final void Function()? onDelete;
//   final void Function()? onUpdate;
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         /// Select or deselect
//         /// pushing id and cart to controller
//       },
//       child: Padding(
//         padding: EdgeInsets.only(bottom: 8.h),
//         child: Container(
//           width: ScreenUtil().screenWidth,
//           height: 90.h,
//           decoration: BoxDecoration(color: Kolors.kOffWhite, borderRadius: kRadiusAll),
//           child: SizedBox(
//             height: 85.h,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Row(
//                   children: [
//                     Container(
//                       decoration: BoxDecoration(
//                           color: Kolors.kWhite,
//                           borderRadius:
//                               BorderRadius.only(bottomRight: Radius.circular(12), topRight: Radius.circular(12))),
//                       child: Stack(
//                         children: [
//                           ClipRRect(
//                             borderRadius: kRadiusAll,
//                             child: SizedBox(
//                               width: 76.w,
//                               height: double.infinity,
//                               child: CachedNetworkImage(imageUrl: cart.product.imageUrls[0], fit: BoxFit.cover),
//                             ),
//                           )
//                         ],
//                       ),
//                     )
//                   ],
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fashion_django/common/utils/kcolors.dart';
import 'package:fashion_django/common/widgets/app_style.dart';
import 'package:fashion_django/common/widgets/reusable_text.dart';
import 'package:fashion_django/const/constants.dart';
import 'package:fashion_django/src/cart/ViewModel/cart_provider.dart';
import 'package:fashion_django/src/cart/models/cart_model.dart';
import 'package:fashion_django/src/products/views/widgets/product_sizes_selection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../products/viewModel/selected_product_notifier.dart';

class CartTile extends ConsumerWidget {
  const CartTile({required this.cart, super.key, this.onDelete, this.onUpdate});

  final CartModel cart;
  final void Function()? onDelete;
  final void Function()? onUpdate;

  @override
  Widget build(BuildContext context, ref) {
    final selectedProduct = ref.watch(selectedProdNotifier);
    return GestureDetector(
      onTap: () {
        // Action for selecting the cart item (if needed)
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        child: Container(
          width: ScreenUtil().screenWidth,
          decoration: BoxDecoration(
            color: Kolors.kOffWhite,
            borderRadius: kRadiusAll,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ),
                child: CachedNetworkImage(
                  imageUrl: cart.product.imageUrls[0],
                  width: 100.w,
                  height: 100.h,
                  fit: BoxFit.cover,
                ),
              ),

              // Product details and actions
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(12.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Product Name
                      Text(
                        cart.product.title,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),

                      SizedBox(height: 4.h),

                      // Product Price
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '\$${(cart.product.price * cart.quantity).toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 10.w),
                          ReusableText(
                              text: "SIZE: ${getSizeLabel(selectedProduct.size)}  ||  COLOR: ${selectedProduct.color}",
                              style: appStyle(10, Kolors.kGray, FontWeight.normal))
                        ],
                      ),

                      SizedBox(height: 10.h),

                      // Quantity and Update/Delete buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Quantity controls
                          Row(
                            children: [
                              IconButton(
                                icon: Icon(Icons.remove_circle_outline, color: Kolors.kPrimary),
                                onPressed: () {
                                  // Decrease quantity
                                  if (onUpdate != null) onUpdate!();
                                  ref
                                      .read(cartNotifierProvider.notifier)
                                      .updateCartItemQuantity(cart.id, cart.quantity - 1);
                                },
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.w),
                                child: Text(
                                  cart.quantity.toString(),
                                  style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.add_circle_outline, color: Kolors.kPrimary),
                                onPressed: () {
                                  // Increase quantity
                                  if (onUpdate != null) onUpdate!();
                                  ref
                                      .read(cartNotifierProvider.notifier)
                                      .updateCartItemQuantity(cart.id, cart.quantity + 1);
                                },
                              ),
                            ],
                          ),

                          // Delete button
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.redAccent),
                            onPressed: onDelete,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
