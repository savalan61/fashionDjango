import 'package:fashion_django/common/utils/app_routes.dart';
import 'package:fashion_django/common/utils/kcolors.dart';
import 'package:fashion_django/common/widgets/app_style.dart';
import 'package:fashion_django/common/widgets/reusable_text.dart';
import 'package:fashion_django/src/categories/controllers/category_riverpod.dart';
import 'package:fashion_django/src/categories/models/categories_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../categories/controllers/categories_riverpod.dart';

class HomeCategoriesList extends ConsumerWidget {
  const HomeCategoriesList({super.key});

  void setSelectedCat(CategoryModel cat, WidgetRef ref) {
    ref.read(catNotifierProvider.notifier).setIdAndCsat(cat);
  }

  @override
  Widget build(BuildContext context, ref) {
    return ref.watch(fetchCatProvider).when(data: (data) {
      return Padding(
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
                      router.push("/category");
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
        ),
      );
    }, error: (error, stackTrace) {
      return const Center(
        child: Text("Error"),
      );
    }, loading: () {
      return const Center(
        child: CircularProgressIndicator(),
      );
    });
  }
}
// class HomeCategoriesList extends ConsumerWidget {
//   const HomeCategoriesList({super.key});
//
//   @override
//   Widget build(BuildContext context, ref) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 3.w),
//       child: SizedBox(
//         height: 80.h,
//         child: SingleChildScrollView(
//           scrollDirection: Axis.horizontal,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: List.generate(
//               categories.length,
//               (index) {
//                 CategoryModel cat = categories[index];
//                 return GestureDetector(
//                   onTap: () {
//                     context.read<CategoryNotifier>().setCategoryAndId(category: cat.title, id: cat.id);
//                     ref.watch(catNotifierProvider.notifier).setIdAndCsat(cat);
//                     router.push("/category");
//                   },
//                   child: SizedBox(
//                     width: 80.w,
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         CircleAvatar(
//                           backgroundColor: Kolors.kSecondaryLight,
//                           child: Padding(
//                             padding: EdgeInsets.all(4.h),
//                             child: SvgPicture.network(cat.imageUrl, width: 40.w, height: 40.h),
//                           ),
//                         ),
//                         ReusableText(
//                           text: cat.title,
//                           overflow: TextOverflow.ellipsis,
//                           style: appStyle(12, Kolors.kGray, FontWeight.normal),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
