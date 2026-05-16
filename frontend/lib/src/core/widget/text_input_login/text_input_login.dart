import 'package:flutter/material.dart';
import 'package:frontend/src/core/themes/color_app.dart';
import 'package:frontend/src/core/themes/estilos_app.dart';

class TextInputLogin extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData? icono;
  final bool obscureText;
  final TextInputType? keyboardType;

  const TextInputLogin({
    super.key,
    required this.controller,
    required this.label,
    this.icono,
    this.obscureText = false,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      style: const TextStyle(color: ColorApp.colorTexto),
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: icono != null ? Icon(icono, color: ColorApp.colorTextoMuted) : null,
        labelStyle: const TextStyle(color: ColorApp.colorTextoMuted),
        filled: true,
        fillColor: ColorApp.colorFondoInput,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(EstilosApp.borderRadiusInput),
          borderSide: const BorderSide(color: ColorApp.colorBordeInput),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(EstilosApp.borderRadiusInput),
          borderSide: const BorderSide(color: ColorApp.colorBordeInput),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(EstilosApp.borderRadiusInput),
          borderSide: const BorderSide(color: ColorApp.colorBordeFoco, width: 2),
        ),
      ),
    );
  }
}
