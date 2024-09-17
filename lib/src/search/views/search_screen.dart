import 'package:fashion_django/common/utils/kcolors.dart';
import 'package:fashion_django/common/widgets/app_style.dart';
import 'package:fashion_django/common/widgets/back_button.dart';
import 'package:fashion_django/common/widgets/empty_screen_widget.dart';
import 'package:fashion_django/common/widgets/reusable_text.dart';
import 'package:fashion_django/src/search/viewModel/search_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import '../../products/views/widgets/staggered_tile_widget.dart';
import '../../wishList/viewModel/wishlist_notifier.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  Future<void> _refreshData() async {
    ref.invalidate(fetchSearchProduct(_searchController.text));
  }

  @override
  Widget build(BuildContext context) {
    final searchResults = ref.watch(fetchSearchProduct(_searchController.text));

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: const AppBackButton(),
        centerTitle: true,
        title: ReusableText(
          text: "Search",
          style: appStyle(16, Kolors.kPrimary, FontWeight.bold),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(70.h),
          child: Padding(
            padding: EdgeInsets.all(14.w),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                ref.invalidate(fetchSearchProduct(value));
              },
              decoration: InputDecoration(
                hintText: "Search For Latest Fashion",
                prefixIcon: GestureDetector(
                  onTap: () => ref.invalidate(fetchSearchProduct(_searchController.text)),
                  child: const Icon(
                    AntDesign.search1,
                    color: Kolors.kPrimary,
                  ),
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    ref.invalidate(fetchSearchProduct(''));
                  },
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
        child: RefreshIndicator(
          onRefresh: _refreshData,
          child: searchResults.when(
            data: (data) {
              if (data.isEmpty) {
                return const Center(
                  child: SingleChildScrollView(child: EmptyScreenWidget()),
                );
              }
              return ListView(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.h, vertical: 10.h),
                    child: StaggeredGrid.count(
                      crossAxisCount: 4,
                      mainAxisSpacing: 6.w,
                      crossAxisSpacing: 6.w,
                      children: List.generate(
                        data.length,
                        (index) {
                          const double mainAxisCellCount = 2.4;
                          final product = data[index];

                          // Fetching wishlist state for each product
                          final isWished = ref.watch(wishListNotifierProvider).when(
                                data: (wishList) => wishList.any(
                                  (item) => item.product.id == product.id,
                                ),
                                loading: () => false,
                                error: (_, __) => false,
                              );

                          return StaggeredGridTile.count(
                            crossAxisCellCount: 2,
                            mainAxisCellCount: mainAxisCellCount,
                            child: StaggeredTileWidget(
                              i: index,
                              product: product,
                              isWished: isWished,
                              onTap: () {
                                ref.read(wishListNotifierProvider.notifier).toggleWishList(product.id.toString());
                              },
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
              child: ReusableText(
                text: "Something went wrong",
                style: appStyle(13, Kolors.kPrimary, FontWeight.w600),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
