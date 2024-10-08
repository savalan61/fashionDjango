import 'package:fashion_django/common/widgets/back_button.dart';
import 'package:fashion_django/common/widgets/reusable_text.dart';
import 'package:flutter/material.dart';

import '../../../common/utils/kcolors.dart';
import '../../../common/widgets/app_style.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: const AppBackButton(),
        centerTitle: true,
        title: ReusableText(text: "Orders", style: appStyle(16, Kolors.kPrimary, FontWeight.bold)),
      ),
    );
  }
}
