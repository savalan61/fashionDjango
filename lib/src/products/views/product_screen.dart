// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fashion_django/common/widgets/app_style.dart';
import 'package:fashion_django/common/widgets/back_button.dart';
import 'package:fashion_django/common/widgets/reusable_text.dart';
import 'package:fashion_django/src/products/controllers/product_notifier.dart';
import 'package:fashion_django/src/products/views/widgets/similar_products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';

import '../../../common/utils/kcolors.dart';
import '../../../const/constants.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key, required this.productId});

  final String productId;

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductNotifier>(
      builder: (context, provider, child) {
        return Scaffold(
          body: CustomScrollView(
            slivers: [
              ///----------------- SliverAppbar(Image and Favorite Button) -----------------------
              SliverAppBar(
                backgroundColor: Colors.white,
                expandedHeight: 320.h,
                collapsedHeight: 65.h,
                floating: false,
                pinned: true,
                leading: const AppBackButton(),
                actions: [
                  Padding(
                    padding: EdgeInsets.only(right: 16.w),
                    child: GestureDetector(
                      onTap: () {},
                      child: CircleAvatar(
                        backgroundColor: Kolors.kSecondaryLight,
                        child: Icon(AntDesign.heart, color: Kolors.kRed, size: 18),
                      ),
                    ),
                  ),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: false,
                  background: SizedBox(
                    height: 415.h,
                    child: ImageSlideshow(
                        autoPlayInterval: 15000,
                        isLoop: provider.product!.imageUrls.length > 1 ? true : false,
                        indicatorColor: Kolors.kPrimary,
                        height: 415.h,
                        children: List.generate(
                          provider.product!.imageUrls.length,
                          (index) => CachedNetworkImage(
                            placeholder: placeholder,
                            errorWidget: errorWidget,
                            imageUrl: provider.product!.imageUrls[index],
                            fit: BoxFit.cover,
                          ),
                        )),
                  ),
                ),
              ),

              ///----------------- Sliver Box() -----------------------
              // space
              SliverToBoxAdapter(
                child: SizedBox(height: 10.h),
              ),

              // Category and Rating
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ReusableText(
                          text: provider.product!.clothesType.toUpperCase(),
                          style: appStyle(13, Kolors.kGray, FontWeight.w600)),
                      Row(
                        children: [
                          Icon(AntDesign.star, color: Kolors.kGold, size: 14),
                          SizedBox(width: 5.w),
                          ReusableText(
                              text: provider.product!.ratings.toStringAsFixed(1),
                              style: appStyle(13, Kolors.kGray, FontWeight.normal))
                        ],
                      )
                    ],
                  ),
                ),
              ),

              // Title
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child:
                      ReusableText(text: provider.product!.title, style: appStyle(16, Kolors.kDark, FontWeight.w600)),
                ),
              ),

              // Description
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(8.h),
                  child: ReadMoreText(
                    provider.product!.description,
                    trimMode: TrimMode.Line,
                    trimLines: 2,
                    colorClickableText: Colors.pink,
                    trimCollapsedText: 'View more',
                    trimExpandedText: 'View less',
                    textAlign: TextAlign.justify,
                    style: appStyle(13, Kolors.kGray, FontWeight.normal),
                    moreStyle: appStyle(11, Kolors.kPrimary, FontWeight.normal),
                    lessStyle: appStyle(11, Kolors.kPrimary, FontWeight.normal),
                  ),
                ),
              ),

              // space
              SliverToBoxAdapter(child: SizedBox(height: 10.h)),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Divider(thickness: .5),
                ),
              ),

              // Select Sizes
              SliverToBoxAdapter(
                  child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: ReusableText(text: "Select sizes", style: appStyle(16, Kolors.kDark, FontWeight.w600)),
              )),
              SliverToBoxAdapter(child: SizedBox(height: 10.h)),

              SliverToBoxAdapter(
                  child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: ReusableText(text: "Select Color", style: appStyle(16, Kolors.kDark, FontWeight.w600)),
              )),
              SliverToBoxAdapter(child: SizedBox(height: 10.h)),

              SliverToBoxAdapter(
                  child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: ReusableText(text: "Similar Products", style: appStyle(16, Kolors.kDark, FontWeight.w600)),
              )),
              SliverToBoxAdapter(child: SizedBox(height: 10.h)),

              // Similar Products
              SliverToBoxAdapter(
                  child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: SimilarProducts(),
              )),
              SliverToBoxAdapter(child: SizedBox(height: 10.h)),
            ],
          ),
        );
      },
    );
  }
}
