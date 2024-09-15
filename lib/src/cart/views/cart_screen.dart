import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // String? accessToken = Storage().getString("accessToken");
    // if (accessToken == null) {
    //   return LoginScreen();
    // }
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart Screen"),
        centerTitle: true,
      ),
      backgroundColor: Colors.red,
    );
  }
}
