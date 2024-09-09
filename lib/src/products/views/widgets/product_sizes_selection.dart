import 'package:fashion_django/common/utils/kcolors.dart';
import 'package:fashion_django/common/widgets/app_style.dart';
import 'package:fashion_django/common/widgets/reusable_text.dart';
import 'package:fashion_django/src/products/controllers/product_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ProductSizesWidget extends StatelessWidget {
  const ProductSizesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductNotifier>(
      builder: (context, provider, child) {
        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          scrollDirection: Axis.horizontal,
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              provider.product!.sizes.length,
              (index) {
                return GestureDetector(
                    onTap: () {
                      provider.setSizes(provider.product!.sizes[index]);
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 20.w),
                      height: 30.h,
                      width: 45.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: provider.product!.sizes[index] == provider.size ? Kolors.kPrimary : Kolors.kGrayLight),
                      child: Center(
                        child: ReusableText(
                            text: provider.product!.sizes[index], style: appStyle(20, Kolors.kWhite, FontWeight.bold)),
                      ),
                    ));
              },
            ),
          ),
        );
      },
    );
  }
}
