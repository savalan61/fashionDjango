import 'package:fashion_django/common/utils/app_routes.dart';
import 'package:fashion_django/common/utils/kcolors.dart';
import 'package:fashion_django/common/widgets/app_style.dart';
import 'package:fashion_django/common/widgets/reusable_text.dart';
import 'package:fashion_django/const/constants.dart';
import 'package:fashion_django/main.dart';
import 'package:fashion_django/src/categories/controllers/category_notifier.dart';
import 'package:fashion_django/src/categories/models/categories_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class HomeCategoriesList extends StatelessWidget {
  const HomeCategoriesList({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 3.w),
      child: SizedBox(
        height: 80.h,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: List.generate(
              categories.length,
              (index) {
                CategoryModel cat = categories[index];
                return GestureDetector(
                  onTap: () {
                    context.read<CategoryNotifier>().setCategoryAndId(category: cat.title, id: cat.id);
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
  }
}
