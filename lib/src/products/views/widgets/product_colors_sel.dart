import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../common/utils/kcolors.dart';
import '../../../../common/widgets/app_style.dart';
import '../../../../common/widgets/reusable_text.dart';
import '../../controllers/product_notifier.dart';

class ProductColorsWidget extends StatelessWidget {
  const ProductColorsWidget({super.key});

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
              provider.product!.colors.length,
              (index) {
                return InkWell(
                    onTap: () {
                      provider.setColor(provider.product!.colors[index]);
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 20.w),
                      height: 30.h,
                      width: 45.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                              color:
                                  provider.product!.colors[index] == provider.color ? Kolors.kPrimary : Kolors.kPrimary,
                              width: provider.product!.colors[index] == provider.color ? 3 : .1),
                          color: provider.product!.colors[index] == provider.color
                              ? getColorFromString(provider.product!.colors[index])
                              : getColorFromString(provider.product!.colors[index])),
                      child: Center(
                        child: ReusableText(
                            text: provider.product!.colors[index],
                            style: appStyle(
                                14,
                                provider.product!.colors[index] == "white" ? Colors.black : Kolors.kWhite,
                                FontWeight.bold)),
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
