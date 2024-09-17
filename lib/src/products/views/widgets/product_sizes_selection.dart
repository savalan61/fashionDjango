import 'package:fashion_django/common/utils/kcolors.dart';
import 'package:fashion_django/common/widgets/app_style.dart';
import 'package:fashion_django/common/widgets/reusable_text.dart';
import 'package:fashion_django/src/products/models/product_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../viewModel/selected_product_notifier.dart';

class ProductSizesWidget extends ConsumerWidget {
  const ProductSizesWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ProductState prodState = ref.watch(selectedProdNotifier);
    final List<String> sizes = prodState.product?.sizes ?? [];
    final String? selectedSize = prodState.size;

    Widget _buildSizeOption(String size) {
      final bool isSelected = size == selectedSize;
      final Color backgroundColor = isSelected ? Kolors.kPrimary : Kolors.kGrayLight;

      return GestureDetector(
        onTap: () => ref.read(selectedProdNotifier.notifier).setSize(size),
        child: Container(
          margin: EdgeInsets.only(right: 20.w),
          height: 30.h,
          width: 45.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: backgroundColor,
          ),
          child: Center(
            child: ReusableText(
              text: size,
              style: appStyle(20, Kolors.kWhite, FontWeight.bold),
            ),
          ),
        ),
      );
    }

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: sizes.map(_buildSizeOption).toList(),
      ),
    );
  }
}
