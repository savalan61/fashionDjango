import 'package:fashion_django/common/utils/app_routes.dart';
import 'package:fashion_django/common/utils/kcolors.dart';
import 'package:fashion_django/common/widgets/app_style.dart';
import 'package:fashion_django/common/widgets/reusable_text.dart';
import 'package:fashion_django/src/categories/models/categories_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../const/resource.dart';
import '../../../categories/viewModel/categories_riverpod.dart';
import '../../../categories/viewModel/category_riverpod.dart';

class HomeCategoriesList extends ConsumerWidget {
  const HomeCategoriesList({super.key});

  void setSelectedCat(CategoryModel cat, WidgetRef ref) {
    ref.read(catNotifierProvider.notifier).setIdAndCsat(cat);
  }

  @override
  Widget build(BuildContext context, ref) {
    final AsyncValue<List<CategoryModel>> refWatch = ref.watch(fetchTopCatsProvider);
    return refWatch.when(
        data: (data) {
          return data.isNotEmpty
              ? Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3.w),
                  child: SizedBox(
                    height: 80.h,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: List.generate(
                          data.length,
                          (index) {
                            CategoryModel cat = data[index];
                            return GestureDetector(
                              onTap: () {
                                setSelectedCat(cat, ref);
                                router.push("/category/${cat.id}");
                              },
                              child: SizedBox(
                                width: 80.w,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Kolors.kSecondaryLight,
                                      child: Padding(
                                        padding: EdgeInsets.all(4.h),
                                        child: SvgPicture.network(cat.imageUrl, width: 40.w, height: 40.h),
                                      ),
                                    ),
                                    ReusableText(
                                      text: cat.title,
                                      overflow: TextOverflow.ellipsis,
                                      style: appStyle(12, Kolors.kGray, FontWeight.normal),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ))
              : Image.asset(R.ASSETS_IMAGES_EMPTY_PNG);
        },
        error: (error, stackTrace) => const Center(child: Text("Not Found")),
        loading: () => const Center(child: CircularProgressIndicator()));
  }
}
