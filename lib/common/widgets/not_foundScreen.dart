import 'package:flutter/material.dart';

import '../../const/resource.dart';

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(38.0),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(image: DecorationImage(image: AssetImage(R.ASSETS_IMAGES_EMPTY_PNG))),
        ),
      ),
    );
  }
}
