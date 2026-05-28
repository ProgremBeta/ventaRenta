 import 'package:intl/intl.dart';

String FormatoMoneda(num valorDB) {
  return '\$${NumberFormat('#,##0', 'es').format(valorDB)} pesos';
}