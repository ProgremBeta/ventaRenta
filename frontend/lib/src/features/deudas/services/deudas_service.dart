import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:frontend/src/core/config/dio_conexion.dart';

class DeudasService {
  final Dio _dio = DioConexion().dio;

  Future<List<dynamic>> deudas() async{
    try {
      final result = await _dio.get('/api/deudas');
      return result.data;
    } catch (err) {
      debugPrint('error al mostrar deudas $err');
      return [];
    }
  }
}