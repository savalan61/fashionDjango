import 'package:fashion_django/src/products/models/product_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/utils/kcolors.dart';
import '../../../../common/widgets/app_style.dart';
import '../../../../common/widgets/reusable_text.dart';
import '../../viewModel/selected_product_notifier.dart';

class ProductColorsWidget extends ConsumerWidget {
  const ProductColorsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ProductState prodState = ref.watch(selectedProdNotifier);
    final List<String> colors = prodState.product!.colors;
    final String? selectedColor = prodState.color;

    Widget _buildColorOption(String color) {
      final bool isSelected = color == selectedColor;
      final Color borderColor = isSelected ? Kolors.kPrimary : Kolors.kPrimary;
      final double borderWidth = isSelected ? 3 : 0.1;
      final Color textColor = color == "white" ? Colors.black : Kolors.kWhite;
      final Color backgroundColor = getColorFromString(color);

      return InkWell(
        onTap: () => ref.read(selectedProdNotifier.notifier).setColor(color),
        child: Container(
          margin: EdgeInsets.only(right: 20.w),
          height: 30.h,
          width: 45.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: borderColor, width: borderWidth),
            color: backgroundColor,
          ),
          child: Center(
            child: ReusableText(
              text: color,
              style: appStyle(14, textColor, FontWeight.bold),
            ),
          ),
        ),
      );
    }

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: colors.map(_buildColorOption).toList(),
      ),
    );
  }
}
