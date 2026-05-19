 import 'package:intl/intl.dart';

String FormatoMoneda(double valorDB){
  return NumberFormat.currency(
      locale: 'es_CO',
      symbol: '\$',
      decimalDigits: 0,
    ).format(valorDB);
}