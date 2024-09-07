// ignore_for_file: prefer_const_constructors

import 'package:fashion_django/src/home/views/widgets/home_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(preferredSize: Size.fromHeight(110.h), child: HomeAppBar()),
      backgroundColor: Colors.purple,
    );
  }
}
