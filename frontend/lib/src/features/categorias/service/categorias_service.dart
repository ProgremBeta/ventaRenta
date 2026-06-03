import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:frontend/src/core/config/dio_conexion.dart';

class CategoriasService {
  final Dio _dio = DioConexion().dio;

  Future<List<Map<String, dynamic>>> categoriasProductos() async {
    try {
      final response = await _dio.get('/api/categorias_productos');
      debugPrint("📡 [CategoriasService] GET /api/categorias_productos → ${response.statusCode}");
      debugPrint("📦 ${response.data}");

      final data = response.data;
      if (data is List) {
        return data.cast<Map<String, dynamic>>();
      }
      return [];
    } catch (e) {
      debugPrint("❌ [CategoriasService] GET /api/categorias_productos → $e");
      return [];
    }
  }

  Future<bool> crearCategoriaProducto(Map<String, dynamic> data) async {
    try {
      final response = await _dio.post('/api/categorias_productos', data: data);
      debugPrint("📡 [CategoriasService] POST /api/categorias_productos → ${response.statusCode}");
      debugPrint("📦 ${response.data}");
      return true;
    } catch (e) {
      debugPrint("❌ [CategoriasService] POST /api/categorias_productos → $e");
      return false;
    }
  }

  Future<List<Map<String, dynamic>>> categoriasDispositivos() async {
    try {
      final response = await _dio.get('/api/categorias_dispositivos');
      debugPrint("📡 [CategoriasService] GET /api/categorias_dispositivos → ${response.statusCode}");
      debugPrint("📦 ${response.data}");
      final data = response.data;
      if (data is List) {
        return data.cast<Map<String, dynamic>>();
      }
      return [];
    } catch (e) {
      debugPrint("❌ [CategoriasService] GET /api/categorias_dispositivos → $e");
      return [];
    }
  }

  Future<bool> crearCategoriaDispositivo(Map<String, dynamic> data) async {
    try {
      final response = await _dio.post('/api/categorias_dispositivos', data: data);
      debugPrint("📡 [CategoriasService] POST /api/categorias_dispositivos → ${response.statusCode}");
      debugPrint("📦 ${response.data}");
      return true;
    } catch (e) {
      debugPrint("❌ [CategoriasService] POST /api/categorias_dispositivos → $e");
      return false;
    }
  }
}
