// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fashion_django/common/utils/kcolors.dart';
import 'package:fashion_django/common/widgets/app_style.dart';
import 'package:fashion_django/common/widgets/reusable_text.dart';
import 'package:fashion_django/src/products/controllers/product_notifier.dart';
import 'package:fashion_django/src/products/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class StaggeredTileWidget extends StatelessWidget {
  const StaggeredTileWidget({super.key, required this.i, required this.product, this.onTap});

  final int i;
  final ProductModel product;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    // String? accessToken = Storage().getString("accessToken");
    return GestureDetector(
      onTap: () {
        context.read<ProductNotifier>().setProduct(product);
        context.push("/product/${product.id}");
        // router.push("/product/${product.id}");
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          color: Kolors.kOffWhite,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Picture and Favorite Button
              Container(
                height: i % 2 == 0 ? 163.h : 180.h,
                color: Kolors.kPrimary,
                child: Stack(
                  children: [
                    CachedNetworkImage(
                        height: i % 2 == 0 ? 163.h : 180.h, imageUrl: product.imageUrls[0], fit: BoxFit.cover),

                    ///TODO
                    Positioned(
                      right: 10.h,
                      top: 10.h,
                      child: GestureDetector(
                        onTap: onTap,
                        child: CircleAvatar(
                          backgroundColor: Kolors.kSecondaryLight,
                          child: Icon(AntDesign.heart, color: Kolors.kRed, size: 18),
                        ),
                      ),
                    )
                  ],
                ),
              ),

              /// Title and Rating
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .3,
                        child: Text(
                          product.title,
                          overflow: TextOverflow.ellipsis,
                          style: appStyle(13, Kolors.kDark, FontWeight.w600),
                        ),
                      ),
                      Row(children: [
                        const Icon(AntDesign.star, color: Kolors.kGold, size: 14),
                        SizedBox(width: 5.w),
                        ReusableText(
                            text: product.ratings.toStringAsFixed(1),
                            style: appStyle(18, Kolors.kGray, FontWeight.normal))
                      ])
                    ],
                  ),
                ),
              ),

              /// Price
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.w),
                  child: ReusableText(
                      text: "\$ ${product.price.toStringAsFixed(2)}",
                      style: appStyle(17, Kolors.kDark, FontWeight.w500)))
            ],
          ),
        ),
      ),
    );
  }
}
