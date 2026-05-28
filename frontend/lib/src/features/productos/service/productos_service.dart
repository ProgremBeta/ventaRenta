import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:frontend/src/core/config/dio_conexion.dart';

class ProductosService {
  final Dio _dio = DioConexion().dio;

  Future<List<Map<String, dynamic>>> productos() async {
    try {
      final response = await _dio.get('/api/productos');
      debugPrint("📡 [ProductosService] GET /api/productos → ${response.statusCode}");
      debugPrint("📦 ${response.data}");
      final List<dynamic> data = response.data;
      return data.cast<Map<String, dynamic>>();
    } on DioException catch (e) {
      debugPrint("❌ [ProductosService] GET /api/productos → ${e.response?.statusCode} ${e.response?.data}");
      return [];
    }
  }

  Future<bool> crearProducto(Map<String, dynamic> data) async {
    try {
      final response = await _dio.post('/api/nuevo_producto', data: data);
      debugPrint("📡 [ProductosService] POST /api/nuevo_producto → ${response.statusCode}");
      debugPrint("📦 ${response.data}");
      return true;
    } on DioException catch (e) {
      debugPrint("❌ [ProductosService] POST /api/nuevo_producto → ${e.response?.statusCode} ${e.response?.data}");
      return false;
    }
  }

  Future<bool> actualizarProducto(int id, Map<String, dynamic> data) async {
    try {
      final response = await _dio.put('/api/productos/$id', data: data);
      debugPrint("📡 [ProductosService] PUT /api/productos/$id → ${response.statusCode}");
      debugPrint("📦 ${response.data}");
      return true;
    } on DioException catch (e) {
      debugPrint("❌ [ProductosService] PUT /api/productos/$id → ${e.response?.statusCode} ${e.response?.data}");
      return false;
    }
  }
}
