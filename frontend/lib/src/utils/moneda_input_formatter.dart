import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class MonedaInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) return newValue;

    final digitsOnly = newValue.text.replaceAll(RegExp(r'\D'), '');
    if (digitsOnly.isEmpty) return const TextEditingValue();

    final number = int.parse(digitsOnly);
    final formatted = NumberFormat('#,##0', 'es').format(number);

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

int? parseMoneda(String text) {
  final digitsOnly = text.replaceAll(RegExp(r'\D'), '');
  if (digitsOnly.isEmpty) return null;
  return int.tryParse(digitsOnly);
}
