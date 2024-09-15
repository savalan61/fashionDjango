// ignore_for_file: prefer_const_constructors

import 'package:fashion_django/common/utils/kcolors.dart';
import 'package:fashion_django/common/utils/kstrings.dart';
import 'package:fashion_django/common/widgets/app_style.dart';
import 'package:fashion_django/common/widgets/back_button.dart';
import 'package:fashion_django/common/widgets/reusable_text.dart';
import 'package:fashion_django/src/categories/models/categories_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:go_router/go_router.dart';

import '../../../const/resource.dart';
import '../viewModel/categories_riverpod.dart';
import '../viewModel/category_riverpod.dart';

class CategoriesScreen extends ConsumerWidget {
  const CategoriesScreen({super.key});

  void setCat(CategoryModel cat, WidgetRef ref) => ref.read(catNotifierProvider.notifier).setIdAndCsat(cat);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(fetchAllCatsProvider).when(
          data: (cats) => cats.isNotEmpty
              ? Scaffold(
                  appBar: AppBar(
                    centerTitle: true,
                    automaticallyImplyLeading: false,
                    title:
                        ReusableText(text: AppText.kCategories, style: appStyle(16, Kolors.kPrimary, FontWeight.bold)),
                    leading: const AppBackButton(),
                  ),
                  body: ListView.builder(
                    itemCount: cats.length,
                    itemBuilder: (context, index) {
                      CategoryModel cat = cats[index];
                      return ListTile(
                        onTap: () {
                          // Got Category Page
                          setCat(cat, ref);
                          context.push("/category/${cat.id}");
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
                  ))
              : Image.asset(R.ASSETS_IMAGES_EMPTY_PNG),
          error: (error, stackTrace) => Center(child: Text("Not Found")),
          loading: () => Center(child: CircularProgressIndicator()),
        );
  }
}
