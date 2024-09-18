import 'package:fashion_django/common/utils/app_routes.dart';
import 'package:fashion_django/common/utils/kcolors.dart';
import 'package:fashion_django/common/widgets/app_style.dart';
import 'package:fashion_django/common/widgets/back_button.dart';
import 'package:fashion_django/common/widgets/reusable_text.dart';
import 'package:fashion_django/src/search/viewModel/search_notifier.dart';
import 'package:fashion_django/src/wishList/viewModel/wishlist_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import '../../products/views/widgets/staggered_tile_widget.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final searchResults = ref.watch(fetchSearchProduct(_searchController.text));
    ref.watch(wishListNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: AppBackButton(
          onTap: () {
            router.pop();
          },
        ),
        centerTitle: true,
        title: ReusableText(text: "Search", style: appStyle(16, Kolors.kPrimary, FontWeight.bold)),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50.h),
          child: Padding(
            padding: EdgeInsets.all(14.w),
            child: TextField(
              controller: _searchController,
              onSubmitted: (value) {
                ref.invalidate(fetchSearchProduct);
              },
              decoration: InputDecoration(
                hintText: "Search For Latest Fashion",
                prefixIcon: const Icon(
                  AntDesign.search1,
                  color: Kolors.kPrimary,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: searchResults.when(
          data: (data) {
            if (data.isEmpty) {
              return Center(
                child: ReusableText(text: "No results found", style: appStyle(13, Kolors.kPrimary, FontWeight.w600)),
              );
            }
            return ListView(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ReusableText(text: "Search Results", style: appStyle(13, Kolors.kPrimary, FontWeight.w600)),
                  ],
                ),
                Padding(
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
                        bool isWished = ref.read(wishListNotifierProvider).when(
                              data: (data) => data.any((element) => element.product.id == product.id),
                              error: (error, stackTrace) => false,
                              loading: () => false,
                            );
                        return StaggeredGridTile.count(
                          crossAxisCellCount: 2,
                          mainAxisCellCount: mainAxisCellCount,
                          child: StaggeredTileWidget(
                            i: index,
                            product: product,
                            isWished: isWished,
                            onTap: () {},
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, stack) => Center(
            child: ReusableText(text: "Something went wrong", style: appStyle(13, Kolors.kPrimary, FontWeight.w600)),
          ),
        ),
      ),
    );
  }
}
