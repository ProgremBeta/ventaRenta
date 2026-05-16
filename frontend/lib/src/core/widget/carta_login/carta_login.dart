import 'package:flutter/material.dart';
import 'package:frontend/src/core/themes/color_app.dart';

class CartaLogin extends StatelessWidget {
  final Widget? child;
  const CartaLogin({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 420),
      decoration: BoxDecoration(
        color: ColorApp.colorSegundario,
        borderRadius: BorderRadius.circular(15),
      ),
      child: child,
    );
  }
}
