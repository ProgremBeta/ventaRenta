 import 'package:intl/intl.dart';

String formatoMoneda(num valorDB) {
  return '\$${NumberFormat('#,##0', 'es').format(valorDB)} pesos';
}