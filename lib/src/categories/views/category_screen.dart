import 'package:fashion_django/common/utils/kcolors.dart';
import 'package:fashion_django/common/widgets/app_style.dart';
import 'package:fashion_django/common/widgets/back_button.dart';
import 'package:fashion_django/common/widgets/reusable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../products/viewModel/products_riverpod.dart';
import '../../products/views/widgets/staggered_tile_widget.dart';
import '../viewModel/category_riverpod.dart';

class CategoryScreen extends ConsumerWidget {
  const CategoryScreen({required this.catId, super.key});

  final int catId;

  Future<void> _refreshProducts(WidgetRef ref) async {
    await ref.refresh(fetchProductsByCategoryProvider(catId).future);
    print("refresh");
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(fetchProductsByCategoryProvider(catId)).when(
          data: (data) => Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              centerTitle: true,
              title: ReusableText(
                text: ref.watch(catNotifierProvider).title,
                style: appStyle(16, Kolors.kPrimary, FontWeight.bold),
              ),
              leading: const AppBackButton(),
              actions: [ElevatedButton(onPressed: () => _refreshProducts(ref), child: const Text("Refresh"))],
            ),
            body: RefreshIndicator(
              onRefresh: () => _refreshProducts(ref),
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.h),
                  child: StaggeredGrid.count(
                    crossAxisCount: 4,
                    mainAxisSpacing: 4,
                    crossAxisSpacing: 4,
                    children: List.generate(
                      data.length,
                      (index) {
                        const double mainAxisCellCount = 2.4;
                        final product = data[index];
                        return StaggeredGridTile.count(
                          crossAxisCellCount: 2,
                          mainAxisCellCount: mainAxisCellCount,
                          child: StaggeredTileWidget(
                            i: index,
                            product: product,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
          error: (err, stack) => const Center(child: Text("Not Found")),
          loading: () => const Center(child: CircularProgressIndicator()),
        );
  }
}
