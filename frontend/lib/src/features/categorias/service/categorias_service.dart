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
    } on DioException catch (e) {
      debugPrint("❌ [CategoriasService] GET /api/categorias_productos → ${e.response?.statusCode} ${e.response?.data}");
      return [];
    }
  }

  Future<bool> crearCategoriaProducto(Map<String, dynamic> data) async {
    debugPrint("datos recibidos ${data}");
    try {
      final response = await _dio.post('/api/categorias_productos', data: data);
      debugPrint("respuesta de la peticion: ${response}");
      debugPrint("📡 [CategoriasService] POST /api/categorias_productos → ${response.statusCode}");
      debugPrint("📦 ${response.data}");
      return true;
    } on DioException catch (e) {
      debugPrint("❌ [CategoriasService] POST /api/categorias_productos → ${e.response?.statusCode} ${e.response?.data}");
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
    } on DioException catch (e) {
      debugPrint("❌ [CategoriasService] GET /api/categorias_dispositivos → ${e.response?.statusCode} ${e.response?.data}");
      return [];
    }
  }

  Future<bool> crearCategoriaDispositivo(Map<String, dynamic> data) async {
    try {
      final response = await _dio.post('/api/categorias_dispositivos', data: data);
      debugPrint("📡 [CategoriasService] POST /api/categorias_dispositivos → ${response.statusCode}");
      debugPrint("📦 ${response.data}");
      return true;
    } on DioException catch (e) {
      debugPrint("❌ [CategoriasService] POST /api/categorias_dispositivos → ${e.response?.statusCode} ${e.response?.data}");
      return false;
    }
  }
}
