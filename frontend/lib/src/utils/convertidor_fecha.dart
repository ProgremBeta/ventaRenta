import 'package:intl/intl.dart';

String FormatoFecha(String fechaDB){
  DateTime fecha = DateTime.parse(fechaDB);
  return DateFormat('dd/MM/yyyy : hh:mm a').format(fecha);
}
