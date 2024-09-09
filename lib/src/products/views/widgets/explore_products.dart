import 'package:fashion_django/common/services/storage.dart';
import 'package:fashion_django/common/widgets/app_style.dart';
import 'package:fashion_django/common/widgets/login_bottom_sheet.dart';
import 'package:fashion_django/const/constants.dart';
import 'package:fashion_django/src/products/views/widgets/staggered_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ExploreProducts extends StatelessWidget {
  const ExploreProducts({super.key});

  @override
  Widget build(BuildContext context) {
    String? accessToken = Storage().getString("accessToken");
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.h),
      child: StaggeredGrid.count(
          crossAxisCount: 4,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          children: List.generate(
            products.length,
            (index) {
              final double mainAxisCellCount = (index % 2 == 0 ? 2.17 : 2.4);
              final product = products[index];
              return StaggeredGridTile.count(
                  crossAxisCellCount: 2,
                  mainAxisCellCount: mainAxisCellCount,
                  child: StaggeredTileWidget(
                    i: index,
                    product: product,
                    onTap: () {
                      if (accessToken == null) {
                        loginBottomSheet(context);
                      } else {
                        ///handle wishlist
                      }
                    },
                  ));
            },
          )),
    );
  }
}
