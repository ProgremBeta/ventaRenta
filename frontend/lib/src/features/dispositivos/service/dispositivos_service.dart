import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:frontend/src/core/config/dio_conexion.dart';

class DispositivosService {
  final Dio _dio = DioConexion().dio;

  Future<bool> crearDispositivo(Map<String, dynamic> data) async {
    try {
      final response = await _dio.post('/api/dispositivos', data: data);
      debugPrint("📡 [DispositivosService] POST /api/dispositivos → ${response.statusCode}");
      debugPrint("📦 ${response.data}");
      return true;
    } on DioException catch (e) {
      debugPrint("❌ [DispositivosService] POST /api/dispositivos → ${e.response?.statusCode} ${e.response?.data}");
      return false;
    }
  }
}
