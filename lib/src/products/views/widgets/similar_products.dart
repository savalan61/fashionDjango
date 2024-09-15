import 'package:fashion_django/src/products/viewModel/products_riverpod.dart';
import 'package:fashion_django/src/products/views/widgets/staggered_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../../common/services/storage.dart';

class SimilarProducts extends ConsumerWidget {
  const SimilarProducts({required this.catId, super.key});

  final int catId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String? accessToken = Storage().getString("accessToken");
    return ref.watch(fetchSimilarProducts(catId)).when(
        data: (data) => Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.h),
              child: StaggeredGrid.count(
                  crossAxisCount: 4,
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                  children: List.generate(
                    data.length,
                    (index) {
                      // final double mainAxisCellCount = (index % 2 == 0 ? 2.17 : 2.4);
                      const double mainAxisCellCount = 2.4;
                      final product = data[index];
                      return StaggeredGridTile.count(
                          crossAxisCellCount: 2,
                          mainAxisCellCount: mainAxisCellCount,
                          child: StaggeredTileWidget(
                            i: index,
                            product: product,
                            // onTap: () {
                            //   if (accessToken == null) {
                            //     loginBottomSheet(context);
                            //   } else {
                            //     ///handle wishlist
                            //   }
                            // },
                          ));
                    },
                  )),
            ),
        error: (error, stackTrace) => const Center(
              child: Text("Something went wrong"),
            ),
        loading: () => const Center(child: CircularProgressIndicator()));
  }
}
