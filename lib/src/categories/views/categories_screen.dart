// ignore_for_file: prefer_const_constructors

import 'package:fashion_django/common/utils/kcolors.dart';
import 'package:fashion_django/common/utils/kstrings.dart';
import 'package:fashion_django/common/widgets/app_style.dart';
import 'package:fashion_django/common/widgets/back_button.dart';
import 'package:fashion_django/common/widgets/reusable_text.dart';
import 'package:fashion_django/const/constants.dart';
import 'package:fashion_django/src/categories/controllers/category_notifier.dart';
import 'package:fashion_django/src/categories/models/categories_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: ReusableText(text: AppText.kCategories, style: appStyle(16, Kolors.kPrimary, FontWeight.bold)),
          leading: const AppBackButton(),
        ),
        body: ListView.builder(
          itemCount: categories.length,
          itemBuilder: (context, index) {
            CategoryModel cat = categories[index];
            return ListTile(
              onTap: () {
                // Got Category Page
                context.read<CategoryNotifier>().setCategoryAndId(category: cat.title, id: cat.id);
                context.push("/category");
                // router.push("/category");
              },
              leading: CircleAvatar(
                  backgroundColor: Kolors.kSecondaryLight,
                  radius: 18,
                  child: Padding(
                    padding: EdgeInsets.all(8.h),
                    child: SvgPicture.network(cat.imageUrl),
                  )),
              title: ReusableText(text: cat.title, style: appStyle(12, Kolors.kGray, FontWeight.normal)),
              trailing: Icon(
                MaterialCommunityIcons.chevron_double_right,
                size: 18,
              ),
            );
          },
        ));
  }
}
