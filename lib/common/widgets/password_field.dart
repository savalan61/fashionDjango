import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../src/auth/controllers/provider/password_notifier.dart';
import '../utils/kcolors.dart';
import 'app_style.dart';

class PasswordField extends ConsumerWidget {
  const PasswordField({super.key, required this.controller, this.focusNode, this.radius});

  final TextEditingController controller;
  final FocusNode? focusNode;
  final double? radius;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final passNotifier = ref.watch(passNotifierProvider.notifier);
    final passState = ref.watch(passNotifierProvider);

    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: TextFormField(
        cursorColor: Colors.black,
        textInputAction: TextInputAction.next,
        focusNode: focusNode,
        keyboardType: TextInputType.visiblePassword,
        controller: controller,
        obscureText: !passState.passVisible,
        // Inverse the state
        validator: (value) {
          if (value!.isEmpty) {
            return "Please enter a valid password";
          } else {
            return null;
          }
        },
        style: appStyle(12, Kolors.kDark, FontWeight.normal),
        decoration: InputDecoration(
          suffixIcon: GestureDetector(
            onTap: () {
              passNotifier.changePassState(); // Update the state
            },
            child: Icon(
              passState.passVisible ? Icons.visibility : Icons.visibility_off,
              color: Kolors.kGrayLight,
            ),
          ),
          hintText: 'Password',
          prefixIcon: const Icon(
            CupertinoIcons.lock_circle,
            color: Kolors.kGrayLight,
            size: 26,
          ),
          isDense: true,
          contentPadding: const EdgeInsets.all(6),
          hintStyle: appStyle(12, Kolors.kGray, FontWeight.normal),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red, width: 0.5),
            borderRadius: BorderRadius.all(Radius.circular(radius ?? 12)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Kolors.kPrimary, width: 0.5),
            borderRadius: BorderRadius.all(Radius.circular(radius ?? 12)),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Kolors.kRed, width: 0.5),
            borderRadius: BorderRadius.all(Radius.circular(radius ?? 12)),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Kolors.kGray, width: 0.5),
            borderRadius: BorderRadius.all(Radius.circular(radius ?? 12)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Kolors.kGray, width: 0.5),
            borderRadius: BorderRadius.all(Radius.circular(radius ?? 12)),
          ),
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Kolors.kPrimary, width: 0.5),
            borderRadius: BorderRadius.all(Radius.circular(radius ?? 12)),
          ),
        ),
      ),
    );
  }
}
