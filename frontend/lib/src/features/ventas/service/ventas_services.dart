import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:frontend/src/core/config/dio_conexion.dart';

class VentaServices {
  final Dio _dio = DioConexion().dio;

  Future<List<dynamic>> ventas() async {
    try {
      final response = await _dio.get('/api/ventas');
      return response.data; // ← List
    } on DioException catch (e) {
      debugPrint("ERROR: ${e.response?.data}");
      return []; // ← nunca rompes el tipo
    }
  }
}