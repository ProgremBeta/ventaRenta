import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:frontend/src/core/config/dio_conexion.dart';

class ClienteService {
  final Dio _dio = DioConexion().dio;

  Future<bool> crearCliente(Map<String, dynamic> data) async {
    try {
      final response = await _dio.post('/api/clientes', data: data);
      debugPrint("📡 [ClienteService] POST /api/clientes → ${response.statusCode}");
      debugPrint("📦 ${response.data}");
      return true;
    } catch (e) {
      debugPrint("❌ [ClienteService] POST /api/clientes → $e");
      return false;
    }
  }
}
