
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorage{
  final FlutterSecureStorage alamacenamiento = const FlutterSecureStorage();

  guardarSession(String key, String value) async{
    debugPrint('guardando datos en guardar session $value');
    await alamacenamiento.write(key: key, value: value);
  }

  Future<String?> leerSession(String key) async {
    String? value = await alamacenamiento.read(key: key);
    debugPrint('token: $value');
    return value;
  }

  eliminarSession(String key) async{
    await alamacenamiento.delete(key: key);
  }
}